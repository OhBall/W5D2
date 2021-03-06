# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord
  validates :username, :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true 
  validates :password, length:{minimum: 6, allow_nil: true}
  
  has_many :moderated_subs,
    foreign_key: :mod_id,
    class_name: :Sub
  
  has_many :posts,
    foreign_key: :author_id,
    class_name: :Post
    
  attr_reader :password
  after_initialize :ensure_session_token
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end
  
end
