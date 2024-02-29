class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      #Postと関連付ける
      #references型を使用して予想外のidが入らないようにする。
      t.references :post, foreign_key: true
      #Tagと関連付けるためのカラム
      #references型を使用して予想外のidが入らないようにする。
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
