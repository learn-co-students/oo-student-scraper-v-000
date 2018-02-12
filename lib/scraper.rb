require 'open-uri'
require 'pry'
require 'nokogiri'



class Scraper

page_loc = "http://165.227.16.205:41320/fixtures/student-site/"
doc = Nokogiri::HTML(open(page_loc))
x = doc.css(".student-card a .student-name")
a = []
x.each do |y|
  a << y.text
end
binding.pry

  def self.scrape_index_page(index_url)

  end

  def self.scrape_profile_page(profile_url)

  end

end
