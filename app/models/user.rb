class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :introduce, length: { maximum: 200 }
  
  def self.guest
    find_or_created_by!(email: "guest@example.com") do |guest|
      guest.password = SecureRandom.urlsafe_base64
      guest.name = "ゲスト"
      guest.is_deleted = false
    end
  end
  
end
