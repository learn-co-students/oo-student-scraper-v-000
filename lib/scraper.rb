require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_array_of_hashes = []

    doc.css("div.student-card a").each do |person|
      #student = Student.new
      student_hash = {}
      name = person.css(".student-name").text
      location = person.css(".student-location").text
      profile_url = person["href"]
      student_hash[:name] = name
      student_hash[:location] = location
      student_hash[:profile_url] = "http://jinjo39-v-000-149090.nitrousapp.com:3000/" + "#{profile_url}"
      student_array_of_hashes << student_hash
    end
    student_array_of_hashes
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_hash = {}
    links = []

    doc.css("div.social-icon-container a").each do |link|
      links << link["href"]
      links.each do |link|

        if link.include?("twitter")
          student_hash[:twitter] = link
        elsif link.include?("linkedin")
          student_hash[:linkedin] = link
        elsif link.include?("github")
          student_hash[:github] = link
        else
          student_hash[:blog] = link
        end
      end
    end
    student_hash[:profile_quote] =doc.css(".profile-quote").text
    student_hash[:bio] = doc.css("p").text
    student_hash
    end
end

