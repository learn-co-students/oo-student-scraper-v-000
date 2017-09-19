require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    #binding.pry
    index_page.css(".student-card").collect.with_index do |cards, index|
      scraped_students = {}
      scraped_students[:name] = index_page.css(".student-name")[index].text
      scraped_students[:location] = index_page.css(".student-location")[index].text
      scraped_students[:profile_url] = index_page.css(".student-card a")[index]["href"]
      scraped_students
    end
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
     profile_page = Nokogiri::HTML(open(profile_url))
     profile_page.css(".social-icon-container a").each_with_index do |links, index|
       if links["href"].include?("twitter")
         student_hash[:twitter] = links["href"]
       elsif links["href"].include?("linkedin")
         student_hash[:linkedin] = links["href"]
       elsif links["href"].include?("github")
         student_hash[:github] = links["href"]
       else links["href"].include?("blog")
         student_hash[:blog] = links["href"]
       end
    end

   student_hash[:profile_quote] = profile_page.css(".profile-quote").text
   student_hash[:bio] = profile_page.css(".description-holder p").text
   student_hash
  end

end
