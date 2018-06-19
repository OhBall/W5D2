# == Schema Information
#
# Table name: posts
#
#  id        :integer          not null, primary key
#  title     :string           not null
#  url       :string
#  content   :string
#  sub_id    :integer          not null
#  author_id :string           not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :sub
  
  belongs_to :author,
    class_name: :User
end
