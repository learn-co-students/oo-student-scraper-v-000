require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = doc.css('.student-card')
    scraped_students.map do |student_element|
      student = Student.new
      student.name = student_element.css(".student-name").text
      student.location = student_element.css(".student-location").text
      student.profile_url = student_element.css('a').attribute("href").text
      student.index_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = Student.new
    student.bio = doc.css(".description-holder p").text
    doc.css('.social-icon-container a').each do |social_link|
      if social_link.attribute("href").text.include?("linkedin")
        student.linkedin = social_link.attribute("href").text
      elsif
        social_link.attribute("href").text.include?("github")
        student.github = social_link.attribute("href").text
      elsif
        social_link.attribute("href").text.include?("twitter")
        student.twitter = social_link.attribute("href").text
      else
        student.blog = social_link.attribute("href").text
      end
    end
    student.profile_quote = doc.css('.profile-quote').text
    student.profile_hash.reject {|k,v| v.nil? }
  end

end

