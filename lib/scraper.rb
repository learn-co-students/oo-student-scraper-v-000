require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    con = doc.css(".student-card")
    # names = con.collect {|s| s.css(".student-name").text }
    
    con.each { |s|
      student = {}
      # create the data
      name = s.css(".student-name").text
      location = s.css(".student-location").text
      url = s.css("a").attribute("href").value
      #add to hash
      student[:name] = name
      student[:location] = location
      student[:profile_url] = url
      scraped_students << student
    }
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    # get variables
    socials = doc.css(".social-icon-container")
    quote = doc.css(".profile-quote").text
    bio = doc.css(".description-holder p").text
    #create hashes for social links
    socials.css("a").each { |link|
      href = link.attribute("href").value
      if href.include?("twitter")
        scraped_student[:twitter] = href
      elsif href.include?("linkedin")
        scraped_student[:linkedin] = href
      elsif href.include?("github")
        scraped_student[:github] = href
      else 
        scraped_student[:blog] = href
      end
    }
    #add quote and bio hashes
    scraped_student[:profile_quote] = quote
    scraped_student[:bio] = bio
    scraped_student
  end

end



# twitter
# linkedin
# github
# blog
# profile_quote
# bio
