require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student_card|
    students << {
        name: student_card.css(".student-name").text,
        location: student_card.css(".student-location").text,
        profile_url: student_card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_hash = {
      twitter: doc.css(".social-icon-container a")[0].attribute("href").value,
      linkedin: doc.css(".social-icon-container a")[1].attribute("href").value,
      github: doc.css(".social-icon-container a")[2].attribute("href").value,
      blog: doc.css(".social-icon-container a")[3].attribute("href").value,
      profile_quote: doc.css(".vitals-text-container .profile-quote").text,
      bio: doc.css(".description-holder p").text
    }

  end

end
