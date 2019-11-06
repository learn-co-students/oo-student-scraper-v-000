require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))

    scraped_students = []

    doc.css(".student-card").each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(File.read(profile_url))

    scraped_student = {}

    doc.css(".social-icon-container a").each do |student|
      title = student.attribute("href").value
      sliced_title = title.slice(title.index(".")..-1).split(".")[1]
      href = student.attribute("href").value

      if href.include?("linkedin")
        scraped_student[sliced_title.to_sym] = student.attribute("href").value
      elsif href.include?("twitter") || href.include?("github")
        scraped_student[title.split(/[\/.]/)[2].to_sym] = student.attribute("href").value
      elsif href.include?("joe")
        scraped_student[:blog] = student.attribute("href").value
      end
    end

    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".bio-block p").text

    scraped_student
  end

end
