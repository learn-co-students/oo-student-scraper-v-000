require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
       index_url = "http://127.0.0.1:4000/"
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    doc.css(".student-card").each do |student_card|
      student_index_array <<
        {:name => student_card.css(".student-name").text,
          :location => student_card.css(".student-location").text,
          :profile_url => index_url+(student_card.css("a").attribute("href").value)
        }
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

