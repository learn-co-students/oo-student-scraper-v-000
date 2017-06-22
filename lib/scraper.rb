require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #The return value of this method should be an array of hashes in which each hash #represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url.
    roster_page = Nokogiri::HTML(open(index_url))
    students = []
    roster_page.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.css("a").attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # Some students don't have a twitter or some other social link. Be sure to be able to handle that.
    #twitter url, linkedin url, github url, blog url
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    social = profile_page.css(".social-icon-container a").collect {|links| links.attribute("href").value}
    #social array collects all href elements inside social container class, iterate through links to see if they exist, then add to key/value if they do
    social.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".bio-content .description-holder p").text
    student
  end

end

#test = Scraper.scrape_profile_page("fixtures/student-site/students/laura-correa.html")
