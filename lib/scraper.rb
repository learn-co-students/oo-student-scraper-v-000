require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    scraped_students = []
    


    # name = index.css("h4.student-name").text
    

    # location = index.css("p.student-location").text
        #this just gives a long list of all the names, and locations

    index.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |info|
        s_n = info.css("h4.student-name").text
        s_l = info.css("p.student-location").text
        s_p = "./fixtures/student-site/#{info.css("a").attribute("href").text}"
       # binding.pry
       scraped_students << {name: s_n, location: s_l, profile_url: s_p}
     end

    end
    scraped_students
    # binding.pry
  end





  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    p_h = {}

    profile.css(".social-icon-container a").each do |info|
      p_h[:linkedin] = info.attribute("href").text if info.attribute("href").text.include?("linkedin")
      p_h[:twitter] = info.attribute("href").text if info.attribute("href").text.include?("twitter")
      p_h[:github] = info.attribute("href").text if info.attribute("href").text.include?("github")
      p_h[:blog] = info.attribute("href").text if info.css("img").attribute("src").text.include?("rss")
    end
    p_h[:profile_quote] = profile.css("div.profile-quote").text
    p_h[:bio] = profile.css("div.description-holder p").text
    # binding.pry
    p_h


  end




end

