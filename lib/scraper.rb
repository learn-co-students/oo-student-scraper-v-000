require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      students << { name: student.css("h4").text, location: student.css("p").text, profile_url: student.css("a").attribute("href").value }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_info = {}

    doc.css("div.vitals-container div.social-icon-container a").each do |site|
      media_type = site.css("img").attribute("src").value.split("/").last.gsub("-icon.png", "")
      media_link = site.attribute("href").value
      if media_type == "rss"
        profile_info[:blog] = media_link
      else
        profile_info[media_type.to_sym] = media_link unless media_type == "facebook.png"
      end
    end

    profile_info[:profile_quote] = doc.css("div.profile-quote").text
    profile_info[:bio] = doc.css("div.description-holder p").text

    profile_info
  end

end



# social media type:  site.css("img").attribute("src").value.split("/").last.gsub("-icon.png", "")
# url: site.attribute("href").value
