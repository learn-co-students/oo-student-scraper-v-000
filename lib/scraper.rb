require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #doc.css("div.student-card").css("a").attribute("href").value # returns one value
    #doc.css("div.student-card").css(".student-name") # returns an array of names
    #doccss("div.student-card").first.css(".student-location")
    hash_array = []
    doc.css("div.student-card").each do |student_card|
      hash_array << {name: student_card.css(".student-name").text, location: student_card.css(".student-location").text, profile_url: student_card.css("a").attribute("href").value}
    end
    return hash_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #:twitter, :linkedin, :github, :blog, :profile_quote, :bio,
    hash = {} #{twitter: "", linkedin: "", github: "", blog: "", profile_quote: "", bio: ""}
    doc.css("div.social-icon-container a").each do |social|
      link = social.attribute("href").text
      if link.include?("twitter")
        hash[:twitter] = link
      elsif link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      else
        hash[:blog] = link
      end
    end
    profile_q = doc.css("div.profile-quote").text
    if(!profile_q.empty?)
      hash[:profile_quote] = doc.css("div.profile-quote").text
    end
    bio = doc.css("div.bio-content p").text
    if(!bio.empty?)
      hash[:bio] = doc.css("div.bio-content p").text
    end
    return hash
  end

end
