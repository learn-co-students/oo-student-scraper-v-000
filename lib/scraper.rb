require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_array = []
    doc.css('.student-card').each {|student|
      new_student = {}
      new_student[:name] = student.css("h4").text
      new_student[:location] = student.css("p").text
      new_student[:profile_url] = student.css("a").attribute("href").value
      students_array << new_student
    }
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    student[:profile_quote] = doc.css('.profile-quote').text
    student[:bio] = doc.css('.description-holder').css('p').text
    social_links_array = doc.css('.social-icon-container').css('a').collect {|a| a.attribute('href').value}
    social_links_array.each {|link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    }
    student
  end

end
