require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|

      studenthash = {:name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value }

        students << studenthash
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_urls = []
    doc.css(".social-icon-container a").each {|i| social_urls << i.attribute("href").value}

    studentattributes = {
      :twitter => social_urls.detect {|i| i.include?("twitter")},
      :linkedin => social_urls.detect {|i| i.include?("linkedin")},
      :github => social_urls.detect {|i| i.include?("github")},
      :blog => social_urls.detect {|i| !i.include?("twitter") && !i.include?("github") && !i.include?("linkedin")},
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text
    }

    studentattributes.keep_if{|key, value| value != nil}

    studentattributes

  end
end
