class Post < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :post_comments, dependent: :destroy
    has_many :favorite, dependent: :destroy
    
    validates :genre_id, presence: true
    validates :body, length: { maximum: 400}
    
    enum posted_status: { published: 0, draft: 1}
end
