require 'nokogiri'
require 'open-uri'
require 'pry'

index_url = 'http://bacitracin-v-000-142249.nitrousapp.com:3000/'

class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes = []
    html = open('http://bacitracin-v-000-142249.nitrousapp.com:3000/')
    doc = Nokogiri::HTML(html)
    students = doc.css('.student-card')

    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = "http://bacitracin-v-000-142249.nitrousapp.com:3000/#{student.css("a").attribute("href").value}"
      array_of_student_hashes << {:name => name, :location => location, :profile_url => profile_url}
    end
    array_of_student_hashes
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    social_links = html.css(".social-icon-container a")
    student_profile_hash = {}

    social_links.each do |link|
      student_profile_hash[:linkedin] = link.attribute("href").value if link.attribute("href").value.include?("linkedin")
      student_profile_hash[:twitter] = link.attribute("href").value if link.attribute("href").value.include?("twitter")
      student_profile_hash[:github] = link.attribute("href").value if link.attribute("href").value.include?("github")
      student_profile_hash[:blog] = link.attribute("href").value if link.css("img").attribute("src").text.include?("rss")
    end
    student_profile_hash[:profile_quote] = html.css("div.profile-quote").text
    student_profile_hash[:bio] = html.css("div.description-holder p").text
    student_profile_hash
    end

end

