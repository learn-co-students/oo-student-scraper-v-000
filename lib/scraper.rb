require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :index_url, :profile_url

  def self.scrape_index_page(index_url)
    
    #responsible for scraping the index page that lists all of the students. This gets a list of all the profiles
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card a").each do |student|
      students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/#{student.attr("href")}"
      }
    end
      students
  end



  def self.scrape_profile_page(profile_url)
    #this scrapes the individual profiles
    html = Nokogiri::HTML(open(profile_url))
      student = {}
      social_links = html.css("div.social-icon-container a").collect {|a| a.attr("href")}

      social_links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("instagram")
          student[:instagram] = link
        elsif link.include?("facebook")
          student[:facebook] = link
        else student[:blog] = link
        end
      end
      student[:profile_quote] = html.css("div.profile-quote").text
      student[:bio] = html.css("div.bio-content.content-holder div.description-holder p").text
      student   
  end
end


