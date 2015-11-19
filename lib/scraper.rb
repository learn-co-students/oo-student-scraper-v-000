require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #link: ("a").attribute("href").value
    #name: ("h4.student-name").text
    #location: ("p.student-location").text
    students = []

    doc.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
      doc.css("div.vitals-container").each do |data| 
        profile = {
            :twitter => data.css("div.social-icon-container").children.css("a")[0].attribute("href").value,
            :linkedin => data.css("div.social-icon-container").children.css("a")[1].attribute("href").value,
            :github => data.css("div.social-icon-container").children.css("a")[2].attribute("href").value,
            :profile_quote => data.css("div.vitals-text-container div").text,
            :bio => doc.css("div.bio-block div.description-holder").text
        }
        #not a good solution will need to revisit
        profile[:blog] = data.css("div.social-icon-container").children.css("a")[3].attribute("href").value if defined?(data.css("div.social-icon-container").children.css("a")[3].attribute("href").value) != nil
      end
    profile
  end

end

