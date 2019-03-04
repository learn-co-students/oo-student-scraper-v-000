require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  student_info = []

  index = Nokogiri::HTML(open(index_url))
  cards = index.css(".student-card")
    cards.each do |student|
    name = student.css(".student-name").text
    location = student.css(".student-location").text
    student_url = student.css("a").attribute("href").value
    student_info << {location: location, name: name, profile_url: student_url}
  end
  student_info
end

def self.scrape_profile_page(profile_url)
  student = {}
  profile_page = Nokogiri::HTML(open(profile_url))
  links = profile_page.css("div.social-icon-container a").collect { |icon| icon.attribute('href').value}
  links.each do |link|
    if link.include?("linkedin")
      student[:linkedin] = link
    elsif link.include?("github")
      student[:github] = link
    elsif link.include?("twitter")
      student[:twitter] = link
    else
      student[:blog] = link
    end
  end
  student[:profile_quote] = profile_page.css(".profile-quote").text
  student[:bio] = profile_page.css("div.description-holder p").text

  student
  end
end
