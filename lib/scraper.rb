require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  scraped_students = []
  doc.css("div.roster-cards-container").each do |student_value|
  student = {}
    student_value.css("div.student-card").each do |student_attr|
      student = {
      :name => student_attr.search("h4.student-name").text,
      :location => student_attr.search("p.student-location").text,
      :profile_url => student_attr.search("a").attribute("href").value
      }
      scraped_students<<student
    end
  end
  scraped_students
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.vitals-container").each do |social_content|
      social.css("div.social-icon-container").each do |social|
        social_link = social.search("a").attribute("href").value
        binding.pry
        case object
        when condition

        end

        end

    end
    #student_profiles = []
    #:twitter =>
    #:linkedin =>
    #:github =>
    #:blog =>
    #:profile_quote =>
    #:bio =>
  end
end
end
