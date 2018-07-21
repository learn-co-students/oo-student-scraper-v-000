require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_link = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students

  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_page.css(".social-icon-container a").each do |icon|
      icon.attribute("href").value
      binding.pry
    end

    binding.pry
    profile_quote = profile_page.css(".profile-quote").text.strip
    binding.pry
  end

end
