require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    scraped_students = []
    student_index_array = Nokogiri::HTML(open(index_url))
    student_index_array.css("div.student-card a").each do |student|
      scraped_students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.attribute("href").value.insert(0, "./fixtures/student-site/")
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    social_links = []
    student_profile_array = Nokogiri::HTML(open(profile_url))
    student_profile_array.css("div.social-icon-container a").each do |soc_link|
      social_links << soc_link.attribute("href").value
      social_links.each do |link|
        if link.include?("twitter")
          student_hash[:twitter] = link
        elsif link.include?("linkedin")
          student_hash[:linkedin] = link
        elsif link.include?("github")
          student_hash[:github] = link
        elsif link.include?("facebook")
          student_hash[:facebook] = link
        elsif link.include?("instagram")
          student_hash[:instagram] = link
        else
          student_hash[:blog] = link
        end
        social_links
      end
    end
    student_hash[:profile_quote] = student_profile_array.css("div.profile-quote").text
    student_hash[:bio] = student_profile_array.css("div.bio-content.content-holder div.description-holder p").text
    student_hash
  end

end
