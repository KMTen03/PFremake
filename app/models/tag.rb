class Tag < ApplicationRecord
  # tag_mapsと関連付けを行い、tag_mapsのテーブルを通しpostsテーブルと関連づけ
  #   dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'

  # postsのアソシエーション
  #   Tag.postsとすれば、タグに紐付けられたPostを取得可能になる
  has_many :posts, through: :post_tags, dependent: :destroy
  
  # バリデーション
  validates :title, presence: true
  validates :content, presence: true
  
  def save_tags(tags)
    tag_list = tag.split(/[[:blank]]+/)
    current_tags = self.tags.pluck(:name)
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
    
    p current_tags
    
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
    
  end
end
