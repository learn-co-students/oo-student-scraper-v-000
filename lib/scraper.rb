require 'open-uri'
require 'nokogiri'
#require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    Nokogiri::HTML(open(index_url)).css(".student-card").collect do |chunk|

      {name: chunk.css("h4").text,
      location: chunk.css("p").text,
      profile_url: "http://127.0.0.1:4000/#{chunk.css("a").attribute("href").value}"}
    end
  end

#Scraper.scrape_index_page("http://127.0.0.1:4000") 


  def self.scrape_profile_page(profile_url)
   
    doc = Nokogiri::HTML(open(profile_url))

    chunk = doc.css(".vitals-container .social-icon-container")
    student = {}

    chunk.css("a").each do |chunk|

      if chunk["href"].include?("twitter")
        student[:twitter] = chunk["href"]
      elsif chunk["href"].include?("linkedin")
        student[:linkedin] = chunk["href"]
      elsif chunk["href"].include?("github")
        student[:github] = chunk["href"]
      else
        student[:blog] = chunk["href"]
      end
    end
      student[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text.gsub(/\s+/, " ")
      student[:bio] = doc.css(".description-holder p").text.gsub(/\s+/, " ")
      student
    end

end


#Scraper.scrape_profile_page("http://127.0.0.1:4000/students/eric-chu.html")



