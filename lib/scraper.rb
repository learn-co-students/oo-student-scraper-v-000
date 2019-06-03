require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    Array.new.tap do |students_array|
      doc.css(".student-card").each do |student|
        students_array << {
          name: student.css(".student-name").text,
          location: student.css(".student-location").text,
          profile_url: student.css("a").attribute("href").value
        }
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    Hash.new.tap do |student_hash|
      doc.css(".social-icon-container a").each do |container|
        case link = container.attribute("href").value
        when /twitter\.com/
          student_hash[:twitter] = link
        when /linkedin\.com/
          student_hash[:linkedin] = link
        when /github\.com/
          student_hash[:github] = link
        else
          student_hash[:blog] = link
        end
      end
      student_hash[:profile_quote] = doc.css(".profile-quote").text
      student_hash[:bio] = doc.css(".bio-content p").text
    end
  end
end
