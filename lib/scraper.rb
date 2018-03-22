require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  #scrapes index page that lists all the students
  # :name, :location, :profile-url
  def self.scrape_index_page(index_url)
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)

    students = []

    doc.css(".student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      students << {:name => name, :location => location, :profile_url => profile_url}
    end
    students
  end

  #scrapes individual student pages for more student info
  #twitter url, linkedin url, github url, blog url, profile quote, and bio
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    individual_student = {}

    #.social-icon-container = row of social media icons
    #create a new array with just the social media/blog urls and
    urls = doc.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}
        #iterate through newly created array of just urls
      urls.each do |url|
        if url.include?("twitter")
          individual_student[:twitter] = url
        elsif url.include?("linkedin")
          individual_student[:linkedin] = url
        elsif url.include?("github")
          individual_student[:github] = url
        else
          individual_student[:blog] = url
        end
    end
      individual_student[:profile_quote] = doc.css(".profile-quote").text
      individual_student[:bio] = doc.css(".bio-block .bio-content .description-holder p").text
    individual_student
  end
end
