require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    students.collect do |student|
      {:name => student.css(".card-text-container h4").text,
      :location => student.css(".card-text-container p").text,
      :profile_url => student.css("a").map{|link| link['href']}[0]}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    socials = doc.css(".vitals-container .social-icon-container a").map{|link| link['href']}
    twitter, linkedin, github, blog = nil
    socials.each do |social|
      if social.include? "twitter"
       twitter = social
     elsif social.include? "linkedin"
       linkedin = social
     elsif social.include? "github"
       github = social
     else
       blog = social
     end
    end
    student = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => doc.css(".vitals-container .vitals-text-container .profile-quote").text,
      :bio => doc.css(".details-container .description-holder p").text
    }
    student.delete_if{|k, v| v.nil?}
  end

end
