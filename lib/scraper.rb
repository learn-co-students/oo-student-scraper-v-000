require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |s|
#      binding.pry
      scraped_students << {
        name: s.css(".student-name").text,
        location: s.css(".student-location").text,
        profile_url: s.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    student = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css(".vitals-container").each do |s|
      s.css("a").each do |link|
        if link.attribute("href").value.include?("twitter")
          student[:twitter] = link.attribute("href").value
        elsif link.attribute("href").value.include?("linkedin")
          student[:linkedin] = link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
          student[:github] = link.attribute("href").value
        else
          student[:blog] = link.attribute("href").value
        end

        s.css(".vitals-text-container").each do |q|
          student[:profile_quote] = q.css(".profile-quote").text
        end
      end

      doc.css(".details-container").each do |d|
        d.css(".description-holder").css("p").each do |b|
          student[:bio] = b.text
        end
      end
    end
    student
  end
end
