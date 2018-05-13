require 'pry'
require 'open-uri'

class Scraper
  attr_accessor :twitter, :linkedin, :github, :blog, :profile_quote, :bio

	def self.scrape_index_page(index_url)
    students = []
    name = ""
    location = ""
    profile_url = ""

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each do |i| 
    students << {
    name: i.css("h4.student-name").text,
    location: i.css("p.student-location").text, 
    profile_url: "http://127.0.0.1:4000/fixtures/student-site/#{i.css("a").first["href"]}"
   }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_container = doc.css("div.social-icon-container") 
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".description-holder p").text
    profile = {}

    social_container.css("a").each do |i|
    if i.attribute("href").value.include?("twitter")
     twitter = i.attribute("href").value
       elsif i.attribute("href").value.include?("github")
         github = i.attribute("href").value
       elsif i.attribute("href").value.include?("linkedin")
         linkedin = i.attribute("href").value
       elsif i.children[0].attribute("src").value == "../assets/img/rss-icon.png"
         blog = i.attribute("href").value
       end
    end
    profile = {
    :twitter => twitter,
    :linkedin => linkedin,    
    :github => github,
    :blog => blog,
    :profile_quote => profile_quote,
    :bio => bio
    }

    profile.each do |key, value|
    profile.delete(key) if value == ""

    end
    profile
  end

end

