require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))
     index_array = []
     doc.css("div.student-card").each do |student|
       student_hash = {
         name: student.css("h4.student-name").text,
         location: student.css("p.student-location").text,
         profile_url: student.css("a").attribute("href").value
       }
       index_array << student_hash
     end
     index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    doc.css("div.social-icon-container a").each do |link|
      url = link.attribute("href").value
      platform = nil

      if url.include?("twitter")
        platform = "twitter"
      elsif url.include?("linkedin")
        platform = "linkedin"
      elsif url.include?("github")
        platform = "github"
      else
        platform = "blog"
      end
      profile_hash[platform.to_sym] = url if platform
    end

    profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    profile_hash[:bio] = doc.css("div.bio-block p").text
    profile_hash
  end
end
