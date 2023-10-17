class Author < ApplicationRecord
    has_many :book_authors
    has_many :books, through: :book_authors, dependent: :destroy

    validates :name, :birth_date, :photo_url, presence: true
    validates :name, uniqueness: true
end
