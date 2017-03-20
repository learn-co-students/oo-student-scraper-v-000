require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    html = File.read(index_url)
    student_scraper = Nokogiri::HTML(html)

    student_scraper.css("div.student-card").collect do |s|

      each_student = {
        :name => s.css("div.card-text-container h4.student-name").text,
        :location => s.css("div.card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/#{s.css("a").attribute("href").value}"
      }
      student_index_array << each_student

    end

    student_index_array

  end

  def self.scrape_profile_page(profile_url)
    all_students = {}
    html = File.read(profile_url)
    student_scraper = Nokogiri::HTML(html)

    student_scraper.css("div.main-wrapper").collect do |s|

      s.css("div.vitals-container a").each do |h|
        link = h.attribute("href").value
        if link.include? "https://twitter.com/"
          all_students[:twitter] = link
        elsif link.include? "https://www.linkedin.com/"
            all_students[:linkedin] = link
        elsif link.include? "https://github.com"
          all_students[:github] = link
        else
          all_students[:blog] = link
        end
      end

      bio = s.css("div.details-container div.bio-block.details-block div.description-holder").text
      # bio.slice!("\n              ")
      # bio.slice!("\n            ")

      all_students[:profile_quote] = s.css("div.vitals-container div.vitals-text-container div.profile-quote").text
      all_students[:bio] = bio.strip

    end
    all_students
  end


end
