require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    names = []
    locations = []
    scraped_students = []
    doc = Nokogiri::HTML(index)
    student_data = doc.css(".student-card")

    student_data.each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    #twitter, linkedin, github, blog, profile_quote, bio
    index = open(profile_url)
    info = {}
    social_links = []
    doc = Nokogiri::HTML(index)
    social_links = doc.css(".social-icon-container a")
    quote = doc.css(".profile-quote").text
    bio_text = doc.css(".description-holder p").text

    social_links.each do |type|
      link = type.attribute("href").value
      #seems like i should be able to refactor this into a more meta an flexible process?
      if link.match(/(linked)/) != nil
        info[:linkedin] = link
      elsif link.match(/(twitter)/) != nil
        info[:twitter] = link
      elsif link.match(/(github)/) != nil
        info[:github] = link
      else
        info[:blog] = link
      end
    end
    
    info[:profile_quote] = quote
    info[:bio] = bio_text
    info
  end

end

