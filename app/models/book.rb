class Book < ApplicationRecord
  has_one :review
  has_many :user_books
  has_many :users

  require 'addressable/uri'

  def self.search_books(keyword)
    encoded_uri = Addressable::URI.encode(
      "https://www.googleapis.com/books/v1/volumes?q=#{keyword}"
    )
    parsed_uri = URI.parse(encoded_uri)
    JSON.parse(Net::HTTP.get(parsed_uri))
  end

  def self.set_search_result(result, books)
    result['items'].each do |item|
      uid = item['id']
      title = item['volumeInfo']['title'] ||= ''
      authors = item['volumeInfo']['authors'] ||= []
      image_url = item['volumeInfo']['imageLinks'] ? item['volumeInfo']['imageLinks']['thumbnail'].sub(/http/, 'https') : 'book-default.png'

      book = {
        uid: uid,
        title: title,
        authors: authors.join(', '),
        image_url: image_url
      }
      books << book
    end
    books
  end
end
