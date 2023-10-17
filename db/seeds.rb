# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "net/http"

BookAuthor.delete_all
BookGenre.delete_all
Book.delete_all
Author.delete_all
Genre.delete_all

author_ids = ["OL23919A", "OL395837A", "OL1394865A", "OL2830895A", "OL53305A", "OL25712A", "OL30765A"]

author_ids.each do |author|
    begin
        author_uri = URI("https://openlibrary.org/authors/#{author}.json")
        author_info = JSON.parse(Net::HTTP.get(author_uri))

        works_uri = URI("https://openlibrary.org/authors/#{author}/works.json")
        works = JSON.parse(Net::HTTP.get(works_uri))
    rescue => e
        retry
    end
    bio = " "
    if(!author_info["bio"].nil?) 
        if(!author_info["bio"]["value"].nil?)
            bio = author_info["bio"]["value"]
        else
            bio = author_info["bio"]
        end
    end

    author = Author.create(
        name: author_info["name"], 
        birth_date: author_info["birth_date"], 
        bio: bio,
        photo_url: "https://covers.openlibrary.org/a/id/#{author_info["photos"][0]}-M.jpg"
    )

    works["entries"].each do |work|
        edition_uri = URI("https://openlibrary.org#{work["key"]}/editions.json")
        
        begin
            edition = JSON.parse(Net::HTTP.get(edition_uri))["entries"][0]
        rescue => e
            retry
        end
        synopsis = ""
        if(!work["description"].nil?) 
            synopsis = work["description"]
        end

        book = author.books.create(
            title: work["title"],
            synopsis: synopsis,
            page_count: edition.nil? ? nil : edition["number_of_pages"],
            published_date: edition.nil? ? nil : edition["publish_date"],
            isbn: edition.nil? || edition["isbn_10"].nil? ? nil : edition["isbn_10"][0],
            cover_image_url: edition.nil? || edition["isbn_10"].nil? ? nil : "https://covers.openlibrary.org/b/isbn/#{edition["isbn_10"][0]}-M.jpg"
        )
        
        if !work["subjects"].nil?   
            work["subjects"].each do |subject|
                genre = Genre.find_or_create_by(name: subject)
                genre.books << book
            end
        end
    end
end

puts "Created #{Author.count} authors"
puts "Created #{Book.count} books"
puts "Created #{Genre.count} genres"