require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    url = index_url.split("/")
    base_url = url[0] + "//" + url[2] + "/"

    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")

    profiles = []

    students.each do |student|
      student_profile = {}
      student_profile[:name] = student.css(".student-name").text
      student_profile[:location] = student.css(".student-location").text
      student_profile[:profile_url] = base_url + student.css("a").attribute("href").text
      profiles << student_profile
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_hash = {}

    doc.css(".social-icon-container a").each do |detail|
       url = detail.attribute("href").text
       values = url.split("/")

       if values.include?("twitter.com")
         student_hash[:twitter] = url
       elsif values.include?("github.com")
         student_hash[:github] = url
       elsif values.include?("www.linkedin.com")
         student_hash[:linkedin] = url
       else
         student_hash[:blog] = url
       end
    end

    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash
  end
end
