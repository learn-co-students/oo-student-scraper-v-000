require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    index_hash = doc.css(".student-card").map do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash
    end
    index_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_hash = {}
    social_hash[:profile_quote] = doc.css(".profile-quote").text
    social_hash[:bio] = doc.css("p").text

    doc.css(".social-icon-container a").map do |profile|
      #:twitter, :linkedin, :github, :blog, :profile_quote, :bio,
      url = profile.attribute("href").text

      if url.include?("twitter")
        social_hash[:twitter] = url
      elsif url.include?("linkedin")
        social_hash[:linkedin] = url
      elsif url.include?("github")
        social_hash[:github] = url
      elsif url.include?("facebook")
        social_hash[:facebook] = url
      else
        social_hash[:blog] = url
      end
    end
    social_hash
  end
end
