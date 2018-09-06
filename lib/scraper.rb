require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []
    doc.css("div.roster-cards-container div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    properties = {
      :bio => doc.css("div.description-holder p").text,
      :profile_quote => doc.css("div.vitals-text-container div.profile-quote").text
    }
    
    links = doc.css("div.social-icon-container").children.css("a").map {|x| x.attr("href")}
    links.each do |x|
      if x.include?("linkedin")
         properties[:linkedin] = x
      elsif x.include?("github")
        properties[:github] = x
      elsif x.include?("twitter")
        properties[:twitter] = x
      elsif x.include?("youtube")
        properties[:youtube] = x
      elsif x.include?("facebook")
        properties[:facebook] = x
      else  
        properties[:blog] = x
      end
    end
    properties
  end

end

