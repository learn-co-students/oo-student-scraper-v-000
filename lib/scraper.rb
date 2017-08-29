require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

    attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
    student_hash = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.css("a")[0]["href"]
    }
    student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash[:bio] = doc.css("div.description-holder p").text
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text

    doc.css("div.social-icon-container a").each do |social|
      if social["href"].include?("twitter")
      profile_hash[:twitter] = social["href"]
      elsif social["href"].include?("linkedin")
      profile_hash[:linkedin] = social["href"]
      elsif social["href"].include?("github")
      profile_hash[:github] = social["href"]
      else
    profile_hash[:blog] = social["href"]
      end
    end
    profile_hash
  end

end #end class
