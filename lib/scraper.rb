require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    #returns a array of hashes in which each hash 
    #represents a single student

    index_url = "http://127.0.0.1:4000/"

    doc = Nokogiri::HTML(open(index_url))

    array = []

   # name = doc.css(".card-text-container h4.student-name").first.text
   # location = doc.css("p.student-location").first.text 
   # profile_url = doc.css("div.student-card a").attribute("href").value
   
    #div.roster-cards-container 
    doc.css("div.student-card").each do |profile|
    
    array << {
    name: profile.css("div.card-text-container h4.student-name").text,
    location: profile.css("div.card-text-container p.student-location").text,
    profile_url: "http://127.0.0.1:4000/" + profile.css("a")[0]['href']
    }
  end
  array
  end

  def self.scrape_profile_page(profile_url)
    profile_url.slice!(/fixtures\Wstudent-site\W/)
    profile = Nokogiri::HTML(open(profile_url))

    students = {
      profile_quote: profile.css("div.vitals-text-container div.profile-quote").text,
      bio: profile.css("div.description-holder p").text
    }

      profile.css("div.social-icon-container a").each do |social|
        if social['href'].include? "twitter"
          students[:twitter] = social['href']
        elsif social['href'].include? "linkedin"
          students[:linkedin] = social['href']
        elsif social['href'].include? "github"
          students[:github] = social['href']
        else
          students[:blog] = social['href']
        end
      end
    students  
  end

end






