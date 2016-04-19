require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  ## responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    students = doc.css(".student-card a")
    students.each do |student|
      profile_html = student.attribute('href').value
      profile_link = index_url + profile_html
      student_name = student.css("h4").text
      student_location = student.css("p").text
      scraped_students << {name: student_name, location: student_location, profile_url: profile_link}
    end
    scraped_students
  end

  ## responsible for scraping an individual student's profile page_
  ## to get further information about that student
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = {}
    social = doc.css(".social-icon-container a").collect {|link| link.attribute("href").value}
    quote = doc.css(".profile-quote")
    pbio = doc.css(".description-holder p")
    social.each do |url|
      if url.include?("twitter")
        student_profile[:twitter] = url
      elsif url.include?("github")
        student_profile[:github] = url
      elsif url.include?("linkedin")
        student_profile[:linkedin] = url
      else
        student_profile[:blog] = url
      end
    end
    student_profile[:profile_quote] = quote.text
    student_profile[:bio] = pbio.text
    student_profile
  end
end

# scraped_profile = Scraper.scrape_profile_page("http://127.0.0.1:4000/students/joe-burgess.html")
