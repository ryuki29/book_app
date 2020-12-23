module BooksApi
  extend self
  def get_url(keyword)
      url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=30")
      response = HTTParty.get(url)
  end
end