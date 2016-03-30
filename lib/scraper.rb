require 'open-uri'
require 'pry'
require 'nokogiri' #<= do we need this?

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    html = open(index_url)
    index_doc = Nokogiri::HTML(html)
    base = "http://127.0.0.1:4000/"

    index_doc.css("div.student-card").each do |student|
      index = {:name => student.css("div.card-text-container h4.student-name").text,
      :location => student.css("div.card-text-container p.student-location").text,
      :profile_url => base + student.css("a").attribute("href").value}
    student_info << index
  end
    student_info
  end

  def self.scrape_profile_page(profile_url)
    student_links = {}
    html = open(profile_url)
    profile_doc = Nokogiri::HTML(html)
    twitter = nil
    linkedin = nil
    github = nil
    blog = nil
    profile_quote = ""
    bio = ""

    profile_doc.css("div.social-icon-container a").each do |social_link|
      if social_link.css("img").attribute("src").value == "../assets/img/twitter-icon.png"
        twitter = social_link["href"]
      
      elsif social_link.css("img").attribute("src").value == "../assets/img/linkedin-icon.png"
        linkedin = social_link["href"]
    
      elsif social_link.css("img").attribute("src").value == "../assets/img/github-icon.png"
        github = social_link["href"]
      
      elsif social_link.css("img").attribute("src").value == "../assets/img/rss-icon.png"
        blog = social_link["href"]
      
      end
       student_links = {:twitter => twitter, 
        :linkedin => linkedin,
        :github => github,
        :blog => blog,
        :bio =>  profile_doc.css("div.description-holder p").text,
        :profile_quote => profile_doc.css("div.profile-quote").text}
      end
      student_links.delete_if {|key, value| value == nil}
    end
    

end

