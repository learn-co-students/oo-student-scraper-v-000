require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    all_students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        all_students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    all_students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
      web_addresses = profile_page.css(".social-icon-container").children.css('a').map{|el| el.attribute('href').value}
        web_addresses.each do |link|
          if link.match(/(twitter)/)
            student[:twitter] = link
          elsif link.match(/(linkedin)/)
            student[:linkedin] = link
          elsif link.match(/(github)/)
            student[:github] = link
          else
            student[:blog] = link
        end
      end
      student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end
