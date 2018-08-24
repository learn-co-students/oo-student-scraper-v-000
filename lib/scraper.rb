require 'open-uri'
require 'pry'
require 'nokogiri'
require_relative './student.rb'
#PAGE_URL = './fixtures/student-site/index.html'

class Scraper #Class Methods. We do not need to save the instances of 'scraper' just need to take this info and then pass it along to the student class where it will be store! #we DON'T need to produce instances of 'scraper' that maintain their own attributes

  def self.scrape_index_page(index_url) #* #Takes in an argument of the URL of the index page
    html = open(index_url)
    #("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    student_index_array = []
    doc.css("div.student-card").collect do |student|
      student_index_array << { #push each new student hash into the array here instead of at the end
        name: student.css(".student-name").text,
        location: student.css(".student-location").text, #div.card-text-container
        profile_url: student.css("a").attribute("href").text
      }
    end
  #  binding.pry
    student_index_array
  end

  def self.scrape_profile_page(profile_url) #Hash key/value pair describes an individal student-site.. need to have a default value set bc some do not have a twitter or other social media link...?
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    doc.css("div.social-icon-container a").each do |xml|
      case xml.attribute("href").value
      when /twitter/
        student_hash[:twitter] = xml.attribute("href").value
      when /github/
        student_hash[:github] = xml.attribute("href").value
      when /linkedin/
        student_hash[:linkedin] = xml.attribute("href").value
      else
          student_hash[:blog] = xml.attribute("href").value
      end
    end
      student_hash[:profile_quote] = doc.css("div.profile-quote").text
      student_hash[:bio] = doc.css("div.bio-content div.description-holder").text.strip
    student_hash
  end

end
