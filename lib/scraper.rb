require 'open-uri'
require 'pry'
require 'nokogiri'



class Scraper

  def self.scrape_index_page(index_url)
    page_loc = "http://165.227.60.187:32963/fixtures/student-site/"
    doc = Nokogiri::HTML(open(page_loc))
    studs_divs = doc.css(".student-card a h4")
    studs_names = []
    studs_divs.each do |stud_div|
      studs_names << stud_div.text
    end
    studs_names
  end

  def self.scrape_profile_page(profile_url)

  end

end
