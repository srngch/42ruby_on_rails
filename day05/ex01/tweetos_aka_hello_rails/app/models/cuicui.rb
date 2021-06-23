class Cuicui < ActiveRecord::Base
    has_many :likes
    has_many :comments
    has_many :users, through: :comments

    belongs_to :user

    # scope :top, lambda { implementez ici }

    def fame

    end

end
