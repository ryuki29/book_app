class Book < ApplicationRecord
  has_many :reviews,    dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_many :users,      through: :user_books

  validates :image_url, presence: true
  validates :uid,       presence: true

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
      image_url = item['volumeInfo']['imageLinks'] ? item['volumeInfo']['imageLinks']['thumbnail'].sub(/http/, 'https') : 'default-book.png'

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
