class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :post_id, uniqueness: { scope: :user_id }
  
  def favorited_?(user)
    favorites.exists?(user_id: user_id)
  end
end
