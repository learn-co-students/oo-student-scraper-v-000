require 'nokogiri'
require 'open-uri'
require 'pry'

class Test

    attr_accessor :name, :books, :url

    def initialize(url)
        @url = url
    end


    def test_page
        doc = Nokogiri::HTML(open(@url))
        books = {}

        doc.css("div.product-shelf-title").each do |title|
            title = doc.css("div.product-shelf-title").text
            books[title.to_sym] = {
                :author => doc.css("div.product-shelf-author a").attribute("href").text,
                :rating => doc.css("div.product-shelf-ratings div.product-last-star div.start star--full").count
            }
        end
    end
end
binding.pry