require 'open-uri'
require "nokogiri"
require 'pry'

class Scraper
  @@students = []
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
  
    doc.css(".student-card").each do |student|
    # binding.pry
    index_student = {
      name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.at("a")["href"]
     }
     @@students << index_student
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    # binding.pry
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    icons = []
    doc.css(".social-icon-container").children.css("a").each do |icon|
      icons << icon.attribute("href").value
    end
    # Check each icon
    icons.each do |icon|
       if icon.include?("twitter")
        student[:twitter] = icon 
       elsif icon.include?("github")
        student[:github] = icon
       elsif icon.include?("linkedin")
        student[:linkedin] = icon
       else
        student[:blog] = icon
       end
    end 
    student[:profile_quote] = doc.css("body > div > div.vitals-container > div.vitals-text-container > div").text.strip
    student[:bio] = doc.css("body > div > div.details-container > div.bio-block.details-block > div > div.description-holder > p").text.strip
     # return hash
    student
  end

end


#  Scraper.scrape_index_page("./fixtures/student-site/index.html")
# Scraper.scrape_profile_page(profile_url)