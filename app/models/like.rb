class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :post_id, uniqueness: { scope: :end_user_id }
  
  def liked_?(user)
    likes.exists?(user_id: user_id)
  end
end
