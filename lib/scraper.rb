require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each {|card|
      card.css(".student-card a").each {|student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        link = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: name, location: location, profile_url: link}
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = profile_page.css(".social-icon-container").children.css("a").collect {|link| link.attribute('href').value}
    social_links.each {|link|
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

    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")

    student
  end

end
