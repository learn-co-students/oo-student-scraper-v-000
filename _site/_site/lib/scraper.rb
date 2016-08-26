require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   html = open(index_url)
   doc = Nokogiri::HTML(html)
   scraped_students = []
     doc.css(".student-card a").each do |person|
    students = {}
    students[:name] = person.css( ".student-name" ).text
    students[:location] = person.css( ".student-location" ).text
    students[:profile_url] = "http://127.0.0.1:4000/" + person["href"]
    scraped_students << students
  end
  scraped_students
end

  def self.scrape_profile_page(profile_url)
   html = open(profile_url)
   doc = Nokogiri::HTML(html)

    icon_hash = {}
    links = []

   doc.css("div.social-icon-container a").each do |link|
    links << link["href"]
    links.each do |link|
     #binding.pry
      if link.include?("twitter")
        icon_hash[:twitter] = link #.css("https://github.com/jmburges")
      elsif link.include?("linkedin")
        icon_hash[:linkedin] = link #.css("https://twitter.com/jmburges")
      elsif link.include?("github")
        icon_hash[:github] = link #.css("https://www.linkedin.com/in/david-kim-38221690")
      elsif
        icon_hash[:blog] = link
       end
      end
     end
       icon_hash[:profile_quote] = doc.css(".profile-quote").text
       icon_hash[:bio] = doc.css("p").text
       icon_hash
   end
  end
