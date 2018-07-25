require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.attr("href")
        scraped_students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    scraped_student[:profile_quote] = doc.css(".profile-quote")[0].text
    scraped_student[:bio] = doc.css(".description-holder p").text
    links_array = doc.css(".vitals-container a")
  #  binding.pry
    counter = 0
      while counter < links_array.length
        if counter == 0
          scraped_student[:twitter] = links_array[counter].attributes["href"].value
        elsif counter == 1
          scraped_student[:linkedin] = links_array[counter].attributes["href"].value
        elsif counter == 2
          scraped_student[:github] = links_array[counter].attributes["href"].value
        elsif counter == 3
          scraped_student[:blog] = links_array[counter].attributes["href"].value
        else
        end
      counter += 1
      end
    scraped_student
  end
end
