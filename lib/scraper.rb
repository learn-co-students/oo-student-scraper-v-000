require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #keys should be :name, :location, :profile_url
    students = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").each do |card|
      card.css("a").each do |student|
        student_hash = Hash.new
        student_hash[:name] = student.css("h4.student-name").text
        student_hash[:location] = student.css("p.student-location").text
        student_hash[:profile_url] = student.attribute("href").value
        students << student_hash
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #use nokogiri and open-uri to access page
    #return valie should be a has in which the key/value pairs describe the student
    #all students wont have the same info
    #:twitter, :linkedin, :github, :blog, :profle_quote, :bio
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = Hash.new

    student_hash[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
    student_hash[:bio] = doc.css("div.details-container div.bio-block div.bio-content div.description-holder p").text

    #fix this
    social_links = doc.css("div.social-icon-container a")
    social_array = social_links.collect {|link| link.attribute("href").value}

    social_array.each do |link|
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

    student_hash
  end

end
