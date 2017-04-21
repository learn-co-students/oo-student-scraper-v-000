require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_hash = []
    students = doc.css(".roster-body-wrapper .student-card")
    students.each do |student|
            student_hash << {:name => student.css(".student-name").text,
              :location => student.css(".student-location").text,
              :profile_url => "./fixtures/student-site/" << student.css("a")[0].attributes["href"].value }
          end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social = doc.css(".social-icon-container")
    {:twitter =>social.css("a:first-of-type")[0].attributes["href"].value,
    :linkedin =>social.css("a:nth-of-type(2)")[0].attributes["href"].value,
    :github =>social.css("a:nth-of-type(3)")[0].attributes["href"].value,
    :blog=>social.css("a:nth-of-type(4)")[0].attributes["href"].value,
    :profile_quote=> doc.css(".vitals-text-container .profile-quote").text,
    :bio=> doc.css(".details-container p").text  }
  end

end
