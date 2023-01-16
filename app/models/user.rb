class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  validates :email, presence: true
  validates :nickname, { presence: true, length: { maximum: 10 } }
  validates :first_name, length: { minimum: 1, maximum: 30 }
  validates :last_name, length: { minimum: 1, maximum: 30 }
  validates :first_name_kana, length: { minimum: 1, maximum: 30 }
  validates :last_name_kana, length: { minimum: 1, maximum: 30 }


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [50, 50]).processed
  end
end
