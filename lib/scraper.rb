require 'open-uri'
require 'pry'
require_relative "../config.rb"

class Scraper

  def self.scrape_index_page(index_url)

    html = File.read(index_url)

    doc = Nokogiri::HTML(html)

    array_name = []
    x = doc.css(".student-name")
    x.each {|element| array_name << element.text}

    array_location = []
    y = doc.css(".student-location")
    y.each {|element| array_location << element.text}

    array_profile = []
    z = doc.css(".student-card").css("a")
    z.each {|element| array_profile << element["href"]}

    array_hashes = []
    for i in 0...array_profile.length do
      array_hashes << {:name => array_name[i], :location => array_location[i], :profile_url => array_profile[i]}
    end
    array_hashes
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    array_links=[]
    x = doc.css(".social-icon-container").css("a")
    x.each {|element| array_links << element["href"]}

    hash = {}
    array_links.each do |element|
      if element.include?("twitter.com")
        hash[:twitter] = element
      elsif element.include?("linkedin.com")
        hash[:linkedin] = element
      elsif element.include?("github.com")
        hash[:github] = element
      elsif element.include?("http")
        hash[:blog] = element
      end
    end

hash[:profile_quote] = doc.css(".profile-quote").text
hash[:bio] = doc.css("p").text
hash
end

end
