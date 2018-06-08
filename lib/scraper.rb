require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []

    doc = Nokogiri::HTML(open('http://67.205.182.198:41498/fixtures/student-site/'))

    cards = doc.css(".student-card")
    #return value is an array of hashes; ea hash reps a single student
    # :name, :location, :profile_url
    cards.each do |card|
      student_hash = {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attribute("href").text
      }
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url = 'http://67.205.152.27:37358/fixtures/student-site/students/ryan-johnson.html')

    individual_student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    link = doc.css(".social-icon-container a")
      link.each do |l|
        sl = l.attribute("href").value     #icon.attribute("href").value exchanged for sl variable
          if sl.include?("twitter")
            individual_student_hash[:twitter] = sl
          elsif sl.include?("linkedin")
            individual_student_hash[:linkedin] = sl
          elsif sl.include?("github")
            individual_student_hash[:github] = sl
          else
            individual_student_hash[:blog] = sl
          end
      end

    individual_student_hash[:profile_quote] = doc.css(".profile-quote").text
    individual_student_hash[:bio] = doc.css(".details-container").css(".description-holder p").text

    individual_student_hash
  end
end
