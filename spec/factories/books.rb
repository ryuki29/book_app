FactoryBot.define do
  factory :book do
    title     { 'エッセンシャル思考 最少の時間で成果を最大にする' }
    authors   { 'グレッグ・マキューン, 高橋璃子' }
    image_url do
      'https://books.google.com/books/content?id=iuU4DAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_ap'
    end
    uid { 'iuU4DAAAQBAJ' }
  end
end
