class Book < ApplicationRecord
    has_many :book_authors
    has_many :authors, through: :book_authors, dependent: :destroy
    has_many :book_genres
    has_many :genres, through: :book_genres, dependent: :destroy

    validates :title, presence: true
    validates :title, :isbn, uniqueness: true
    validates :page_count, numericality: { only_integers: true }
end
