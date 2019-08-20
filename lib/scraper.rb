require 'open-uri'
require 'pry'

class Scraper
  #method is responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []

    doc.css('.student-card').each do |card|
      students << {
        name: card.css('.student-name').text,
        location: card.css('.student-location').text,
        profile_url: card.css('a')[0]['href']
      }
    end
    students
  end


  #method is responsible for scraping an individual student's profile page to get further information about that student.
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student= {}


    links = profile.css(".social-icon-container a").map { |el| el.attribute('href').value}
    links.each do |link|

    if link.include?('twitter')
      student[:twitter] = link
    elsif link.include?('linkedin')
      student[:linkedin] = link
    elsif link.include?('github')
      student[:github] = link
    else
      student[:blog] = link
    end
  end
   student[:profile_quote] = profile.css(".profile-quote").text
   student[:bio] = profile.css(".description-holder p").text
   student
  end
end
