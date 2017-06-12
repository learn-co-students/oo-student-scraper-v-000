require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  BASE_PATH = ""

  def self.scrape_index_page(index_url)

    html = Nokogiri::HTML(open(index_url))

    scraped_students = []

    html.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
         :profile_url => BASE_PATH + student.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    profile_details = {
      :profile_quote => profile.css("div.profile-quote").text,
      :bio => profile.css("div.bio-content div.description-holder p").text
    }

    profile.css("div.social-icon-container a").each do |profile|
      if profile.attribute("href").value.include?("twitter")
        profile_details[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("linkedin")
        profile_details[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        profile_details[:github] = profile.attribute("href").value
      else
        profile_details[:blog] = profile.attribute("href").value
        end
      end

    profile_details

  end
end
