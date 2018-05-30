require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("selector").each do |student|
      students << {
        :name => student.css("selector").text
        :location => student.css("selector").text
        :profile_url => student.css("selector").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {
      :twitter => profile_page.css("selector").text
      :linkedin => profile_page.css("selector").text
      :github => profile_page.css("selector").text
      :blog => profile_page.css("selector").text
      :profile_quote => profile_page.css("selector").text
      :bio => profile_page.css("selector").text
    }
    student
  end

end

