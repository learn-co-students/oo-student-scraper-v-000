require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # The `#scrape_index_page` method is responsible for scraping the index page that lists all of the students
    scraped_students = []

    html = Nokogiri::HTML(open(index_url)) 

    html.css(".student-card").each do |student|
      student_hash = {
        :name => student.css(".student-name").text, 
        :location => student.css("p.student-location").text,
        :profile_url => "http://students.learn.co/" + student.css("a").attribute("href").text
      }
    
    scraped_students << student_hash
  end
  scraped_students
  end

  def self.scrape_profile_page(profile_url)
    # `#scrape_profile_page` method is responsible for scraping an individual student's profile page to get further information about that student
    student = {}
    html = Nokogiri::HTML(open(profile_url))

    html.css(".social-icon-container a").each do |links|
      link = links.attribute("href").text

      student[:linkedin] = link if link.include?("linkedin")
      student[:twitter] = link if link.include?("twitter")
      student[:github] = link if link.include?("github")
      student[:blog] = link if links.css("img").attribute("src").text.include?("rss")
    end

    student[:profile_quote] = html.css(".profile-quote").text
    student[:bio] = html.css(".description-holder p").text

    student

  end

end

