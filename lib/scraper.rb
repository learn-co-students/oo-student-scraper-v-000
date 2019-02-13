require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        profile_link = student.css("a").attribute("href").value
        location =  student.css(".student-location").text
        name = student.css(".student-name").text
         students << {name: name, location: location, profile_url: profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  profile_page = Nokogiri::HTML(open(profile_url))
  student = {}
  student[:profile_quote] = profile_page.css('.profile-quote').text
  student[:bio] = profile_page.css('.description-holder p').text
  profile_page.css('.social-icon-container a').each do |link|
    link = link.attribute('href').value
    case
    when link.include?('twitter')
      student[:twitter] = link
    when link.include?('linkedin')
      student[:linkedin] = link
    when link.include?('github')
      student[:github] = link
    else
      student[:blog] = link
    end
  end
    student
  end
  
end
