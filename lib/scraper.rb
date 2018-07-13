
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url)) #grabs the HTML that
    #makes up index_url and then uses the Nokogiri::HTML method
    #to convert it to a NodeSet that we can use. Save it in doc.
    #binding.pry
    scraped_students = []
    doc.css(".student-card").each do|student|
      scraped_students <<{
      :name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css("a").attr("href").value
    }
    end
     scraped_students
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_info = {}

    profile_info[:bio] = doc.css("p").text
    profile_info[:profile_quote] = doc.css(".profile-quote").text

    media = doc.css(".vitals-container .social-icon-container").children.css("a").collect {|social| social.attribute("href").value}
      #binding.pry
      media.each do |social|
        #binding.pry
     if social.include?("twitter")
       profile_info[:twitter] = social
       #binding.pry
     elsif social.include?("linkedin")
       profile_info[:linkedin] = social
     elsif social.include?("github")
       profile_info[:github] = social
     else
       profile_info[:blog] = social
      # binding.pry
      end
    end
      profile_info
  end
end
