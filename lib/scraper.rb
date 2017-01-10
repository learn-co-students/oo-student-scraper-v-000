require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(open(index_url))
      students = []

      flatiron.css(".student-card").each do |f|
        students << {
          :name => f.css("h4.student-name").text,
          :location => f.css("p.student-location").text,
          :profile_url => f.css("a").attribute("href").text.prepend("./fixtures/student-site/")
        }
      end
      students
  end


  def self.scrape_profile_page(profile_url)

  end

end

#student name: flatiron.css("h4.student-name").text
#location: flatiron.css("p.student-location").text
#profile_url: flatiron.css("a").attribute("href").text
