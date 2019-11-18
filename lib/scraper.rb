require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    learn_students = []

    doc.css("div.roster-cards-container .student-card a").each do |student|
      learn_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attr("href")
      }
    end

    learn_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_profile = {}
    all_social_links = doc.css(".social-icon-container a").map{ |link| link.attr("href") }

    all_social_links.each do |social_link|
      if social_link.include?("twitter")
        student_profile[:twitter] = social_link
      elsif social_link.include?("linkedin")
        student_profile[:linkedin] = social_link
      elsif social_link.include?("github")
        student_profile[:github] = social_link
      else
        student_profile[:blog] = social_link
      end

      student_profile[:profile_quote] = doc.css('div.profile-quote').text
      student_profile[:bio] = doc.css('div.description-holder p').text
    end

    student_profile
  end
end
