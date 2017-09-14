require 'nokogiri'
require 'open-uri'

class Scraper
  def self.scrape_index_page(index_url)
    students = [] #will hold array of student hashes
    doc = Nokogiri::HTML(open(index_url)) #gets the page
    cards = doc.css(".student-card") #array of student cards
    cards.each do |card| #build hash of each student and store in array
      student = {name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: card.at("a")["href"]
      }
      students << student# save each student hash into array
    end
    students #return the array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))# gets the page
    #links = doc.css(".social-icon-container").at("a")["href"]
    nodeset = doc.css('a[href]')    # Get anchors w href attribute via css
    links = nodeset.map {|element| element["href"]} #don't quite understand - got from Stack Overflow
    student = {}
    links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("http")
          student[:blog] = link
        end
        student[:bio] = doc.css(".description-holder p").text
        student[:profile_quote] = doc.css(".profile-quote").text
      end
      student
   end
end
