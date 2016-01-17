require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    
    students = []

    index_page.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/" + student.css("a").attribute("href").value
      }
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    social_links = profile_page.css("div.social-icon-container a")
    profile = {
      # twitter: social_links.css("a")[0].attribute("href").value,
      # linkedin: social_links.css("a")[1].attribute("href").value , 
      # github: social_links.css("a")[2].attribute("href").value , 
      # blog: social_links.css("a")[3].attribute("href").value , 
      profile_quote: profile_page.css("div.vitals-text-container div.profile-quote").text,
      bio: profile_page.css("div.bio-content div.description-holder p").text
    }
    social_links.each do |social|
      blog = (social.attribute("href").value).to_s.gsub!(/http:\/\/|https:\/\/|www.|.com.{1,}/,'')
      if !(blog == "twitter" || blog == "linkedin" || blog == "github")
        profile[:blog] = social.attribute("href").value
      elsif blog == ""
        #nothing I think this was unnecessary
      else
        profile[(social.attribute("href").value).to_s.gsub!(/http:\/\/|https:\/\/|www.|.com.{1,}/,'').to_sym] = social.attribute("href").value
      end
    end
    return profile
  end

end

