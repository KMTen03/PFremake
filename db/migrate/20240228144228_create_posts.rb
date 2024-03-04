class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      #タイトル
      t.string :title, null: false
      #コンテンツ
      t.string :content, null: false
      #学習時間
      t.string :time, null: false
      
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
