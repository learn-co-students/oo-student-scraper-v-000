require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").map do |student|
      students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_sites = {}

    social_media = doc.css(".social-icon-container a").each do |social_media_site|
      src = social_media_site.attribute('href').value

      if src.include?("twitter")
        social_sites[:twitter] = src

      elsif src.include?("linkedin")
        social_sites[:linkedin] = src

      elsif src.include?("github")
        social_sites[:github] = src

      else
        social_sites[:blog] = src
      end
    end
    social_sites[:profile_quote] = doc.css(".profile-quote").text
    social_sites[:bio] = doc.css(".description-holder p").text

    social_sites
  end
end
