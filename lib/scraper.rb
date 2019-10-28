require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    names = doc.css(".student-name")
    names_array = []
    names.each do |name|
      names_array << name.text
    end
    locations = doc.css(".student-location")
    locations_array = []
    locations.each do |location|
      locations_array << location.text
    end
    urls = doc.css(".student-card a[href]")
    url_array = []
    urls.each do |url|
      url_array << url["href"]
    end

    students = []
    names_array.each_with_index do |name, index|
      student = {}
      student[:name] = name
      student[:location] = locations_array[index]
      student[:profile_url] = url_array[index]
      students << student
    end
    students

  end



  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    urls = doc.css(".social-icon-container a[href]")
    url_array = []
    urls.each do |url|
      if url["href"].include? "twitter"
        profile[:twitter] = url["href"]
      elsif url["href"].include? "linkedin"
        profile[:linkedin] = url["href"]
      elsif url["href"].include? "github"
        profile[:github] = url["href"]
      else
        profile[:blog] = url["href"]
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text
    profile

  end
  #binding.pry






end
