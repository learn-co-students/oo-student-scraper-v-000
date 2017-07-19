require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    scraped_students = []
    index_scrape = Nokogiri::HTML(html)

    index_scrape.css("div.student-card").each do |profile|
      scraped_students << {
      :name => profile.css("h4.student-name").text,
      :location => profile.css("p.student-location").text,
      :profile_url => profile.css("a").attribute("href").text
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    scraped_profile = {}
    profile_scrape = Nokogiri::HTML(html)
    profile_scrape.css("div.social-icon-container").children.css("a").each do |element|
      if element.attribute('href').value.include?("linkedin")
        scraped_profile[:linkedin] = element.attribute('href').value
      elsif element.attribute('href').value.include?("twitter")
        scraped_profile[:twitter] = element.attribute('href').value
      elsif element.attribute('href').value.include?("github")
        scraped_profile[:github] = element.attribute('href').value
      elsif element.attribute('href').value.include?("youtube")
        scraped_profile[:youtube] = element.attribute('href').value
      else
        scraped_profile[:blog] = element.attribute('href').value
      end
    end
   scraped_profile[:profile_quote] = profile_scrape.css("div.profile-quote").text
   scraped_profile[:profile_quote] = profile_scrape.css("div.profile-quote").text
   scraped_profile[:bio] = profile_scrape.css("div.description-holder p").text

   scraped_profile
  end

end
