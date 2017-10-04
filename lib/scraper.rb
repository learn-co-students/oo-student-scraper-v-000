require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "http://67.205.182.198:48121/fixtures/student-site/")
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    snames = doc.css("h4.student-name")
    namesarray = []
    snames.each do |a|
      namesarray << a.text
    end
    slocation = doc.css("p.student-location")
    locationsarray = []
    slocation.each do |l|
      locationsarray << l.text
    end
    ssites = doc.css(".student-card a")
    sitesarray = []
    ssites.each do |s|
      sitesarray << s.attributes.first[1].value
    end
    x = sitesarray.length
    sarray = Array.new(x, " ")
    i = 0
    sarray.collect do |hash| #returns modified array. Original array sarray not modified.
      hash = Hash.new
      hash[:name] = namesarray[i]
      hash[:location] = locationsarray[i]
      hash[:profile_url] = sitesarray[i]
      i += 1
      hash #this makes the return value of the loop the new hash. This line is necessary!
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    # attributes needed: twitter url, linkedin url, github url, blog url, profile quote, and bio.
    shash = {}
    links = doc.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin") #the if statement allows it to handle cases where a profile page does not have the link.
        shash[:linkedin] = link
      elsif link.include?("github")
        shash[:github] = link
      elsif link.include?("twitter")
        shash[:twitter] = link
      else
        shash[:blog] = link
      end
    end
    shash[:profile_quote] = doc.css("div.profile-quote").text if doc.css("div.profile-quote")
    shash[:bio] = doc.css("p").text if doc.css("p")
    shash
  end

end
