require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_student = Array.new
    #binding.pry

    #the roster cards container contains all of the student cards
    doc.css("div.roster-cards-container").each do |container|
      #iterate over each student card to locate name, loc, and url
      container.css("div.student-card a").each_with_index do |card,i|
        name = card.css("h4.student-name").text
        location = card.css(".student-location").text
        profile_url = card.attribute("href").value
        #finally, shovel this hash into the existing array
        #once this process is done, it will iterate over the next student card inside the container
        scraped_student << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
    scraped_student
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = Hash.new

    social_links = doc.css(".social-icon-container").css("a").collect{|x|x.attribute("href").value}
    social_links.each do |link|
      profile[:twitter] = link if link.include?("twitter")
      profile[:linkedin] = link if link.include?("linkedin")
      profile[:github] = link if link.include?("github")
      profile[:blog] = link if !link.include?("github") && !link.include?("linkedin") && !link.include?("twitter")
    end

    profile[:profile_quote] = doc.css(".profile-quote").text unless doc.css(".profile-quote").text == nil
    profile[:bio] = doc.css("div.bio-block div.bio-content div.description-holder p").text unless doc.css("div.bio-block div.bio-content div.description-holder p").text == nil

    profile
    end

  end

#Scraper.scrape_index_page("./fixtures/student-site/index.html")
#Scraper.scrape_profile_page("./fixtures/student-site/students/david-kim.html")
