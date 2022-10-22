class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :email, presence: true
  validates :nickname, { presence: true, length: { maximum: 10}}
  validates :first_name, length: { minimum: 1, maximum: 30 }
  validates :last_name, length: { minimum: 1, maximum: 30}
  validates :first_name_kana, length: { minimum: 1, maximum: 30}
  validates :last_name_kana, length: { minimum: 1, maximum: 30}
  
end
