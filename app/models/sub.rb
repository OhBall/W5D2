# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string           not null
#  mod_id      :integer          not null
#

class Sub < ApplicationRecord
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  
  belongs_to :moderator,
    foreign_key: :mod_id,
    class_name: :User
    
  has_many :post_subs,
    foreign_key: :sub_id,
    class_name: :PostSub
  
    has_many :posts,
    through: :post_subs,
    source: :post
    
end
