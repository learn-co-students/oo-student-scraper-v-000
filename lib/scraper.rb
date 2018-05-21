require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    #  html = File.read('fixtures/student-site/index.html')
     doc = Nokogiri::HTML(html)
     doc.css("div.roster-cards-container").each do |student_card|
       binding.pry
       student_card.css(".student_card a").each do |student|
         name = student.css(".student-name").text
         location = student.css(".student-location").text
         profile_url
       end
     end
   end


  def self.scrape_profile_page(profile_url)

  end

end
