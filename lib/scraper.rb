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

    student_hash = {}

    links = doc.css(".social-icon-container a")

    links.each do |l|
      string = l.attribute("href").value

      case
      when string.include?("twitter")
        student_hash[:twitter] = string
      when string.include?("linkedin")
        student_hash[:linkedin] = string
      when string.include?("github")
        student_hash[:github] = string
      else
        student_hash[:blog] = string
      end
    end

    student_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash


  end

end
