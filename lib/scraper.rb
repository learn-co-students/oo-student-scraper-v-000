require 'open-uri'
require 'nokogiri'
require 'pry'
#require_relative '../fixtures/student-site/index.html'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = "http://127.0.0.1:4000/"
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    doc.css(".student-card").each do |student_card|
      student_index_array <<
        {:name => student_card.css(".student-name").text,
          :location => student_card.css(".student-location").text,
          :profile_url => index_url+(student_card.css("a").attribute("href").value)
        }
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student = []
    student_profile.css(".main-wrapper").each do |div|
      student = student_profile.css("a").collect {|link| href = link.attribute("href").value  }
      student.delete_if{|link| "../" == link }
            student_info[:twitter] = student.grep(/twitter/)[0]
              student.delete_if{|link| student_info[:twitter] == link }
            student_info[:linkedin] = student.grep(/linkedin/)[0]
              student.delete_if{|link| student_info[:linkedin] == link }
            student_info[:github] = student.grep(/github/)[0]
              student.delete_if{|link| student_info[:github] == link }
            student_info[:blog] = student.last
            student_info[:profile_quote] = div.css(".profile-quote").text
            student_info[:bio] = div.css(".description-holder p").text
          end
student_info.reject{|key, value| value == nil}
  end
end
