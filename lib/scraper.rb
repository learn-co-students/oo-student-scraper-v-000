require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    #students: index_page.css(".student-card")
    #name: student.css(".student-name").text
    #location:student.css(".student-location").text
    #profile_url: student.css("a").attribute("href").value

    index_page.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    binding.pry
    
    #twitter: profile_page.css(".social-icon-container a").attribute("href").value
    #linkedin: profile_page.css(".social-icon-container a +a").attribute("href").value
    #github: profile_page.css(".social-icon-container a +a +a").attribute("href").value
    #blog: profile_page.css(".social-icon-container a +a +a +a").attribute("href").value

    # the above require that all students have them same social media accounts to share and that they are in the same order, no bueno
    
    #profile_quote: profile_page.css(".profile-quote").text
    #bio: profile_page.css(".description-holder p").text

    student = {
      :twitter => profile_page.css("selector").text,
      :linkedin => profile_page.css("selector").text,
      :github => profile_page.css("selector").text,
      :blog => profile_page.css("selector").text,
      :profile_quote => profile_page.css(".profile-quote").text,
      :bio => profile_page.css(".description-holder p").text
    }
    student
  end

end

