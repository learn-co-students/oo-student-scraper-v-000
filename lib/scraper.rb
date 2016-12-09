require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   binding.pry
   doc = Nokogiri::HTML(open("http://67.205.146.216:30000/fixtures/student-site/"))

  end

  def self.scrape_profile_page(profile_url)

    end
end

=begin UNABLE TO GET CODE TO EXTRACT THE URL
    scraped_students.css().collect do
    {
      :name => doc.css(".card-text-container").first.css("h4").text
      :location => doc.css(".card-text-container").first.css("p").text
      :profile_url =>

    }

  end
end
=end
