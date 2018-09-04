require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").collect do |student_info|
      student_index_hash = {}
      student_index_hash[:name] = student_info.css("h4").text
      student_index_hash[:location] = student_info.css("p").text
      student_index_hash[:profile_url] = student_info.css("a").attribute("href").value
      student_index_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile_hash = {}
     doc.css(".social-icon-container").css("a").each do |social_account|
       #binding.pry
         if social_account.attribute("href").value.include?("twitter")
        student_profile_hash[:twitter] = social_account.attribute("href").value
         elsif social_account.attribute("href").value.include?("linkedin")
           student_profile_hash[:linkedin] = social_account.attribute("href").value
         elsif social_account.attribute("href").value.include?("github")
           student_profile_hash[:github] = social_account.attribute("href").value
         elsif social_account.attribute("href").value.include?(".com")
           student_profile_hash[:blog] = social_account.attribute("href").value
         end
         #binding.pry
       end

    student_profile_hash[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
    student_profile_hash[:bio] = doc.css(".description-holder").css("p").text
    student_profile_hash
  end
end 

