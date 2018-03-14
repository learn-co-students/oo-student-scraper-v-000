require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
      index_page.css("div.roster-cards-container").each do |card|
        card.css(".student-card a").each do |student|
          profile_link = student.attr('href')
          location = student.css('.student-location').text
          name = student.css('.student-name').text
          students << {name: name, location: location, profile_url: profile_link}
        end
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
   profile = Nokogiri::HTML(open(profile_url))
   profile.css(".social-icon-container").each do |sml|
     sml.css("a").each do |link|
       if link.attributes["href"].value.include?("linkedin")
        student[:linkedin] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("github")
        student[:github] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("twitter")
        student[:twitter] = link.attributes["href"].value
      else
        student[:blog] = link.attributes["href"].value
        end
      end

      student[:bio] = profile.css(".description-holder p").text
      student[:profile_quote] = profile.css(".profile-quote").text

    end
    student
  end


end
