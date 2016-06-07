
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :index_url

  def self.scrape_index_page(index_url)
    @index_url = index_url
    create_student_hash
end

  def self.get_page
    doc = Nokogiri::HTML(open(@index_url))
  end

  def self.create_student_hash
    all = []
    get_page.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = "http://127.0.0.1:4000/students/" + student.css("h4").text.downcase.gsub(" ", "-") + ".html"
      Student.new(student_hash)
      all << student_hash
    end
    all
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    doc.css("div.social-icon-container a").each do |social|
      if social.css("img").attribute("src").to_s.include? "twitter"
        student_hash[:twitter] = social["href"]
      elsif social.css("img").attribute("src").to_s.include? "github"
        student_hash[:github] = social["href"]
      elsif social.css("img").attribute("src").to_s.include? "linkedin"
        student_hash[:linkedin] = social["href"]
      elsif social.css("img").attribute("src").to_s.include? "facebook"
        student_hash[:facebook] = social["href"]
      else
        student_hash[:blog] = social["href"]
      end
    end
    student_hash[:profile_quote] = doc.css("div.profile-quote").text
    student_hash[:bio] = doc.css("div.description-holder p").text
    student_hash
  end

end

#
# Scraper.scrape_index_page(index_url)
# # => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "http://127.0.0.1:4000/students/abby-smith.html"},
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "http://127.0.0.1:4000/students/joe-jonas.html"},
# {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "http://127.0.0.1:4000/students/carlos-rodriguez.html"},
# {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "http://127.0.0.1:4000/students/lorenzo-oro.html"},
# {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "http://127.0.0.1:4000/students/marisa-royer.html"}
