require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each {|person|
      students << {
        :name => person.css(".student-name").text,
        :location => person.css(".student-location").text,
        :profile_url => person.css("a").attribute("href").value
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    twitter = nil
    linkedin = nil
    github = nil
    blog = nil
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".bio-content p").text

    social = doc.css(".social-icon-container a")
    social.each {|link|
      link_value = link.attribute("href").value
      if link_value.include?("twitter")
        twitter = link_value
      elsif link_value.include?("linkedin")
        linkedin = link_value
      elsif link_value.include?("github")
        github = link_value
      else
        blog = link_value
      end
    }
    {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => profile_quote,
      :bio => bio
    }
    #binding.pry
  end

end
