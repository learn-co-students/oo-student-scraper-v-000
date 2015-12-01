require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open("#{index_url}"))
    students = doc.css(".student-card")
    students.each do |student|
      hash = { name: student.css(".card-text-container h4").text,
               location: student.css(".card-text-container p").text,
               profile_url: "http://students.learn.co/#{student.css("a")[0]["href"]}"
      }
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    social_links = doc.css(".vitals-container .social-icon-container a")
    student_hash = {name: doc.css(".vitals-container .vitals-text-container .profile-name").text,
            quote: doc.css(".vitals-container .vitals-text-container .profile-quote").text,
            bio: doc.css(".details-container .bio-block .bio-content .description-holder p").text
    }

    social_links.each do |link|
      capture = link["href"].match(/https?:\/{2}w{3}?\.?([a-z]+)/).captures
      case capture[0]
      when "github"
        student_hash[:github] = link["href"]
      when "linkedin"
        student_hash[:linkedin] = link["href"]
      when "twitter"
        student_hash[:twitter] = link["href"]
      else
        student_hash[:blog] = link["href"]
      end
    end
    student_hash
  end
end

