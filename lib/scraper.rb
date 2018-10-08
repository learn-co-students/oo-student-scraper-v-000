require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url) #responsible for scraping the index page that lists all of the students
    doc = Nokogiri::HTML(open(index_url))   #take the HTML and turn it into a NodeSet (aka, a bunch of nested "nodes")
    students = []
    doc.css("div.roster-cards-container").each do |card|
       card.css(".student-card a").each do |student|
         name = student.css(".student-name").text
         location = student.css(".student-location").text
         profile_url = "#{student.attr("href")}"
         students << {name: name, location: location, profile_url: profile_url}
       end
    end
    students
  end


  def self.scrape_profile_page(profile_url) #responsible for scraping an individual's student's profile page to get further info about student
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    social_networks = doc.css("div.social-icon-container a").collect do |social|
      social.attribute("href").value
    end
      social_networks.each do |social_link|
        if social_link.include?("linkedin")
        student[:linkedin] = social_link
        elsif social_link.include?("github")
        student[:github] = social_link
        elsif social_link.include?("twitter")
        student[:twitter] = social_link
        else
        student[:blog] = social_link
        end
      end
        student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
        student[:profile_quote] = doc.css("div.profile-quote").text
      student
      end
  end
