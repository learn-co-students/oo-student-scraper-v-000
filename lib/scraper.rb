require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    page = Nokogiri::HTML(html)
    profiles = []
    page.css("div.student-card").each do |profile|
      profiles << {
      :name => profile.css("h4.student-name").text,
      :location => profile.css("p.student-location").text,
      :profile_url => profile.css("a").attribute("href").value
    }
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = File.read(profile_url)
    page = Nokogiri::HTML(html)
    icons = page.css("div.social-icon-container")
    icons.css("a").each do |icon|
      ulink = icon.attribute("href").value
      if ulink.include?("twitter.com")
        scraped_student[:twitter] = ulink
      elsif ulink.include?("github.com")
        scraped_student[:github] = ulink
      elsif ulink.include?("linkedin.com")
        scraped_student[:linkedin] = ulink
      else
        scraped_student[:blog] = ulink
      end
    end
    scraped_student[:bio] = page.css("p").text
    scraped_student[:profile_quote] = page.css("div.profile-quote").text
    scraped_student
  end

end
