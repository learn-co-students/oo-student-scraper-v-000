require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
    profile_url = student.css("a").attribute("href").value
    location = student.css(".student-location").text
    name = student.css(".student-name").text
    students.push(
        name: name,
        location: location,
        profile_url: profile_url,
      )
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    individual_student = {}
    doc = Nokogiri::HTML(open(profile_url))
    individual_student[:profile_quote] = doc.css(".profile-quote").text
    individual_student[:bio] = doc.css(".description-holder").css("p").text
    urls = doc.css('.social-icon-container a[href]')
    url_array = []
    urls.each do |url|
      if url['href'].include? "twitter"
        individual_student[:twitter] = url['href']
      elsif url['href'].include?("linkedin")
        individual_student[:linkedin] = url['href']
      elsif url['href'].include?("github")
        individual_student[:github] = url['href']
      else 
        individual_student[:blog] = url['href']
      end
    end
    individual_student
  end

end
