require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.inject([]) do |acc, student|
      student_hash = {}
      student_hash[:profile_url] = student.css("a[href]").first.attr("href")
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      acc << student_hash
    end
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    profile_info[:profile_quote] = profile.css(".profile-quote").text
    profile_info[:bio] = profile.css(".description-holder p").text

    social = profile.css(".social-icon-container a")
    social.each do |platform|
      attribute = platform.attr("href").split(/https*:\/\/w*\.*|\./)[1]
      if attribute == "linkedin" || attribute == "twitter" || attribute == "github"
        profile_info[attribute.to_sym] = platform.attr("href")
      else
        profile_info[:blog] = platform.attr("href")
      end

    end
    profile_info
  end

end
