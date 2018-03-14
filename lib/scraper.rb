require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_students = Nokogiri::HTML(open(index_url))

    students = []

    learn_students.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    profile = {}

    profile_page.css("div.social-icon-container a").each do |social|
      case social['href']
      when /twitter/
        profile[:twitter] = social['href']
      when /linkedin/
        profile[:linkedin] = social['href']
      when /github/
        profile[:github] = social['href']
      else
        profile[:blog] = social['href']
      end
    end

    profile[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text
    profile[:bio] = profile_page.css("div.bio-content div.description-holder p").text
    profile
  end
end
