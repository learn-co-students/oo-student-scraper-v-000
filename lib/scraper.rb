require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []

    index.css(".student-card").each do |student|
      students << {
        :name => student.css("a .card-text-container .student-name").text,
        :location => student.css("a .card-text-container .student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    students_data = {}

    students_data[:profile_quote] = profile.css(".vitals-container .vitals-text-container .profile-quote").text
    students_data[:bio] = profile.css(".details-container .bio-block .bio-content .description-holder p").text

    profile.css(".social-icon-container a").each do |social|
      case
      when social.attributes["href"].value.include?("twitter")
        students_data[:twitter] = social.attribute("href").value
      when social.attributes["href"].value.include?("linkedin")
        students_data[:linkedin] = social.attribute("href").value
      when social.attributes["href"].value.include?("github")
        students_data[:github] = social.attribute("href").value
      else
        students_data[:blog] = social.attribute("href").value
      end
    end

    students_data
  end
end

# Scraper.scrape_index_page("./fixtures/student-site/index.html")
