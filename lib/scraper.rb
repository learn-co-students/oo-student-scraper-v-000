require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    new_array = []
    students = index.css(".student-card")
    students.each do |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      new_array << hash
    end

    return new_array


  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    profile = Nokogiri::HTML(open(profile_url))

    profile.css("a").each do |link|
      attribute = link.attribute("href").value
      if attribute.include?("twitter")
        hash[:twitter] = attribute
      elsif attribute.include?("linked")
        hash[:linkedin] = attribute
      elsif attribute.include?("github")
        hash[:github] = attribute
      elsif attribute.include?(".com")
        hash[:blog] = attribute
      end
    end
    hash[:profile_quote] = profile.css(".profile-quote").text
    hash[:bio] = profile.css(".description-holder p").text
    return hash
  end




end
