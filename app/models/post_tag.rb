class PostTag < ApplicationRecord
  # tag_mapsテーブルは、postsテーブルとtagsテーブルに属している
  belongs_to :post
  belongs_to :tag

  # 念のためのバリデーション
  validates :post_id, presence: true
  validates :tag_id, presence: true
end
