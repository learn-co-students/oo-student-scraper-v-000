require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    student_array = []
    students.each do |student|
      new_student = {}
      student_link_element = student.css('a')
      new_student[:name] =student_link_element.css("h4.student-name").text
      new_student[:profile_url] = student_link_element[0]['href']
      new_student[:location] =student_link_element.css("p.student-location").text
      student_array << new_student
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = doc.css(".social-icon-container a")
    #binding.pry
    social_links.each do |link|
      #binding.pry
      if link['href'].include?("linkedin")
        student_profile[:linkedin] = link['href']
      elsif link['href'].include?("twitter")
        student_profile[:twitter] = link['href']
      elsif link['href'].include?("github")
        student_profile[:github] = link['href']
      elsif link['href'].include?(".com")
        student_profile[:blog] = link['href']
      end
    end
    student_profile[:bio] = doc.css("div.description-holder p").text
    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile
  end

end
