require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      s = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      students << s
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.vitals-container").css("a").each do |a|
      case
      when a["href"].include?("twitter")
        then student[:twitter] = a["href"]
      when a["href"].include?("linkedin")
        then student[:linkedin] = a["href"]
      when a["href"].include?("github")
        then student[:github] = a["href"]
      else student[:blog] = a["href"]
      end
    end

    doc.css("div.main-wrapper.profile").each do |a|
      student[:profile_quote] = a.css("div.profile-quote").text
      student[:bio] = a.css("div.description-holder p").text
    end
    student
  end

end
