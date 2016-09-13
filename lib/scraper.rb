require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name , :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attr("href").value}"
        }
      end
    students
  end

def self.scrape_profile_page(profile_url)
    attributes_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    attributes_hash[:profile_quote]= doc.css("div.profile-quote").text unless :profile_quote == "" || nil
    attributes_hash[:bio]= doc.css(".description-holder p").text unless :bio == "" || nil

    links = doc.css(".social-icon-container").children.css("a").map { |el| el['href']}

    links.each do |link|
      if link.include? ("twitter")
        attributes_hash[:twitter]= link
      elsif link.include? ("linkedin")
        attributes_hash[:linkedin]= link
      elsif link.include?("github")
        attributes_hash[:github]= link
      elsif link.include?(/.*/)
        attributes_hash[:blog]= link
      end
    end
    attributes_hash
  end
end
