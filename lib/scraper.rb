require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []

    html.css(".student-card").each do |student|
      name = student.css(".card-text-container h4").text
      location = student.css(".card-text-container p").text
      profile_url = student.css("a").attribute("href").value
      students << {:name => name, :location => location, :profile_url => "http://127.0.0.1:4000/" + profile_url}
    end
    students

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    social = profile_page.css(".social-icon-container") 
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    bio = profile_page.css(".description-holder p").text
    quote = profile_page.css(".profile-quote").text
    social.css("a").each do |x|
      if x.attribute("href").value.include?("twitter")
        twitter = x.attribute("href").value
      elsif x.attribute("href").value.include?("github")
        github = x.attribute("href").value
      elsif x.attribute("href").value.include?("linkedin")
        linkedin = x.attribute("href").value
      elsif x.children[0].attribute("src").value == "../assets/img/rss-icon.png"
        blog = x.attribute("href").value
      end
    end
    info = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => quote,
      :bio => bio
     } 
    
    info.each do |key, value|
      info.delete(key) if value == ""
    end

    info
    
  end

end

