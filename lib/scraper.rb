require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")
    students_array = []
    students.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile = {
      # :blog => ,
      :profile_quote => page.css(".profile-quote").text,
      :bio => page.css(".description-holder p").text
    }
    links = page.css(".social-icon-container a")
    links.each do |link|
      # binding.pry
      if link['href'].include?("twitter")
        profile[:twitter] = link['href']
      elsif link['href'].include?("github")
        profile[:github] = link['href']
      elsif link['href'].include?("linkedin")
        profile[:linkedin] = link['href']
      else
        profile[:blog] = link['href']
      end
    end
    profile
  end

end
