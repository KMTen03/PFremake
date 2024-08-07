class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  

  # バリデーション
  validates :tag_ids, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :time, presence: true
  

  def save_tags(tags)

    # タグをスペース区切りで分割し配列にする
    tag_list = tags.split(/[[:blank:]]+/)

    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)

    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #   -- 記事更新時に削除されたタグ
    old_tags = current_tags - tag_list

    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    #   -- 新規に追加されたタグ
    new_tags = tag_list - current_tags

    p current_tags

    # tag_mapsテーブルから、(1)のタグを削除
    #   tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるpost_idとtag_idを削除
      #   後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
    end

    # tagsテーブルから(2)のタグを探して、tag_mapsテーブルにtag_idを追加する
    new_tags.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
      # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_post_tag = Tag.find_or_create_by(name: new)

      # tag_mapsテーブルにpost_idとtag_idを保存
      #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.tags << new_post_tag
    end
  end
  
  def favorited?(user)
    #1 favorited?(user)として、メソッドに引数を指定する。
   favorites.where(user_id: user.id).exists?
    #2 その引数(current_user)のidと等しいuser_idを持つレコードは、
    # favoritesテーブル内に存在するか？をexists?を用いて判断する
  end
    #これによりいいねボタンがクリックされた際、
    #・一致するレコードが存在しない＝「まだいいねしていない→createアクションへ」
    #・一致するレコードが存在する　＝「すでにいいね済み→destroyアクションへ」
    #と分岐させることができる。

  def self.search(keyword) #検索機能
    where("title LIKE ? or learning_time LIKE ? or learning_content LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    # keywordのところに検索した文字列が適用され、そこからタイトルなのか、学習内容の検索なのか判定する
  end

  def self.get_ranking(post) #なぜここに検索機能が
    find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
end
