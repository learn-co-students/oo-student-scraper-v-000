require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    student = doc.css(".roster-body-wrapper")
    holding = []
    names = []
    locations = []
    profiles = []
    
    student_hash = []
    hold = {}
    
    # :name
    # :location
    str = student.css(".card-text-container").text
    str = str.split("\n")
    str.collect { |a| holding << a.strip }
    holding.delete("")
    holding.each_with_index do |a, index|
      if index.even?
        names << a
      else
        locations << a
      end
    end
     
    # :profile_url
    url = student.css("a")
    url.each do |prof|
      profiles << prof.attribute("href").value
    end
  
   # putting together array
   
   names.each_with_index do |name, i|
     hold = {:name => names[i], :location => locations[i], :profile_url => profiles[i]}
     student_hash << hold
   end
   student_hash
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    social = []
    twitter = ""
    linked_in = ""
    github = ""
    blog =""
    
    #gets social networks and puts in an array - social
    profile = doc.css(".social-icon-container a")
    profile.each do |prof|
      social << prof.attribute("href").value
    end
    
    social.each do |site|
      if site.include? "twitter"
        twitter = site
      elsif site.include? "linkedin"
        linked_in = site
      elsif site.include? "github"
        github = site
      else
        blog = site
      end
    end

    #quote
    quote = doc.css(".profile-quote").text
    
    #bio
    bio = doc.css(".bio-content.content-holder .description-holder p").text

    #putting together hash
    prof = {:twitter => twitter, :linkedin => linked_in, :github => github, :blog => blog, :profile_quote => quote, :bio => bio }
    
    prof.collect do |key, value|
      if value == ""
        prof.delete(key)
      end
    end
    prof
  end
end
Scraper.scrape_profile_page("./fixtures/student-site/students/david-kim.html")