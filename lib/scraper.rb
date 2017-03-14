require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  #scrape index page that lists all of the students
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      link = student.css("a").map {|link| link['href']}
      person = {:name => student.css("h4").text, :location => student.css("p").text, :profile_url => "./fixtures/student-site/#{link[0]}"}
      students << person
      # binding.pry
    end
    students
  end

  #responsible for scraping an individual student's profile page
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css("a").map {|link| link['href']}
    twitter = nil
    linkedin = nil
    github = nil
    blog = nil
    student = {:profile_quote => doc.css(".profile-quote").text, :bio => doc.css(".description-holder p").text}
    links.each do |link|
      if link.include? "twitter"
        student[:twitter] = link
      elsif link.include? "linkedin"
        student[:linkedin] = link
      elsif link.include? "github"
        student[:github] = link
      elsif link != "../"
        student[:blog] = link
      end
    end
    student
    # binding.pry
  end

end
