require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students = Nokogiri::HTML(html)
    scraped_students = []

    students.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/"+student.css("a").attribute('href').value
      }
    end

    scraped_students #return the array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student = Nokogiri::HTML(html)
    scraped_student = {}

    social=["twitter", "linkedin", "facebook", "github"]
    student.css("div.social-icon-container a").each do |l|
      link_url = l['href']
      key =""
      social.each {|s| key = s if link_url.include?(s) }
      key ==""? scraped_student[:blog]= link_url : scraped_student[key.to_sym]= link_url
    end

    scraped_student[:profile_quote] = student.css("div.profile-quote").text
    scraped_student[:bio]= student.css("div.description-holder p").text

    scraped_student
  end
end #end of class

scraper = Scraper.new
#scraper.class.scrape_index_page("./fixtures/student-site/index.html")
scraper.class.scrape_profile_page("./fixtures/student-site/students/david-kim.html")
