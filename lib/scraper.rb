require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    scraped_students = Nokogiri::HTML(html)
    array = []
    #binding.pry
    scraped_students.css("div.student-card").each do |student|
      array << {:name => student.css("a div.card-text-container h4.student-name").text, :location => student.css("a div.card-text-container p.student-location").text, :profile_url => student.css("a").attribute("href").value }
      #name = student.css("a div.card-text-container h4.student-name").text
      #location = student.css("a div.card-text-container p.student-location").text
      #url = student.css("a").attribute("href").value
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    scraped_profile = Nokogiri::HTML(html)
    student_hash = {}
    i = 0

    while i < scraped_profile.css("div.social-icon-container a").length
      hashvalue = scraped_profile.css("div.social-icon-container a")[i].attribute("href").value
      key = scraped_profile.css("div.social-icon-container a")[i].attribute("href").value.gsub("https:\/\/www.","").gsub("http:\/\/www.","").gsub("https:\/\/","").gsub("http:\/\/","")
      case key[0..2]
      when "twi"
        student_hash[:twitter] = hashvalue
      when "git"
        student_hash[:github] = hashvalue
      when "lin"
        student_hash[:linkedin] = hashvalue
      else
        student_hash[:blog] = hashvalue
      end
      i += 1
    end
    student_hash[:profile_quote] = scraped_profile.css("div.profile-quote").text
    student_hash[:bio] = scraped_profile.css("div.description-holder p").text
    student_hash
  end

end
