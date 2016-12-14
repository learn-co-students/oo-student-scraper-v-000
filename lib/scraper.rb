require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('.student-card').each do |student|
      student_hash = {}
      student_hash[:name] = student.css('.student-name').text
      student_hash[:location] = student.css('.student-location').text
      student_hash[:profile_url] = "./fixtures/student-site/#{student.css("a").attr('href').value}"
      students << student_hash
      # binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    doc.css('.social-icon-container-card').collect do |link|
      if link.include?("twitter")
        student[:twitter] = link.css('a')['href']
        binding.pry
      elsif link.include?("linkedin")
        student[:linkedin] = link.css('a')['href']

     end
   end
    # student[:twitter] = doc.css(".social-icon-container a")[0]['href']
    # student[:linkedin] = doc.css(".social-icon-container a")[1]['href']
    # student[:github] = doc.css(".social-icon-container a")[2]['href']
    # student[:blog] = doc.css(".social-icon-container a")[3]['href']
    # student[:profile_quote] = doc.css(".profile-quote").text
    # student[:bio] = doc.css(".description-holder p").text

    student

  end

end
