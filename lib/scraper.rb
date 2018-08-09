require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    doc.css(".student-card").each do |student_card|
      students << {:name => student_card.css("h4.student-name").text, :location => student_card.css("p.student-location").text, :profile_url => student_card.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped = {
      :profile_quote => doc.css('div.vitals-text-container div.profile-quote').text,
      :bio => doc.css('div.description-holder p').text
    }
    socials = doc.css('div.social-icon-container a')
    socials.each do |social|
      url = social.attribute('href').value
      if url.include?('twitter')
        scraped[:twitter] = url
      elsif url.include?('github')
        scraped[:github] = url
      elsif url.include?('linkedin')
        scraped[:linkedin] = url
      else 
        scraped[:blog] = url
      end 
    end
    scraped
  end	  
end

