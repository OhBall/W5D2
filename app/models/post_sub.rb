# == Schema Information
#
# Table name: post_subs
#
#  id      :integer          not null, primary key
#  post_id :integer          not null
#  sub_id  :integer          not null
#

class PostSub < ApplicationRecord
  
  belongs_to :post
  
  belongs_to :sub 
  
end
