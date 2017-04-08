require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_doc = doc.css("div.student-card")

    students = []

    student_doc.each do |s|
      student = {
        :name => s.css("h4.student-name").text,
        :location => s.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/#{s.css("a").attribute("href").value}"
      }

      students << student
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_doc = doc.css("div.vitals-container")

    profile = {}

    profile_doc.each do |social|

      links = []
      social.css("div.social-icon-container a").each do |link|
        links << link.attribute("href").value
      end

      profile[:twitter] = "#{links.grep(/twitter/).first.to_s}" if links.grep(/twitter/) != []
      profile[:linkedin] = "#{links.grep(/linkedin/).first.to_s}" if links.grep(/linkedin/) != []
      profile[:github] = "#{links.grep(/github/).first.to_s}" if links.grep(/github/) != []
      profile[:blog] = "#{links.grep(/.com\/$/).first.to_s}" if links.grep(/.com\/$/) != []

      profile[:profile_quote] = "#{social.css("div.profile-quote").text}"
    end

    profile[:bio] = "#{doc.css("div.details-container div.description-holder p").text}"

    profile

  end

end
