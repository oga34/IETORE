class Post < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_one_attached :video
    
    validates :genre_id, presence: true
    validates :body, length: { maximum: 400}
    
    enum status: { published: 0, draft: 1}
    
        def favorited_by?(user)
            favorites.exists?(user_id: user.id)
        end
        
        def favorited_by?(admin)
            favorites.exists?
        end
end
