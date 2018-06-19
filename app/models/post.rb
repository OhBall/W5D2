# == Schema Information
#
# Table name: posts
#
#  id        :integer          not null, primary key
#  title     :string           not null
#  url       :string
#  content   :string
#  author_id :integer          not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :author,
    class_name: :User
    
  has_many :post_subs,
    inverse_of: :post,
    foreign_key: :post_id,
    class_name: :PostSub
    
  has_many :subs,
    through: :post_subs,
    source: :sub
end
