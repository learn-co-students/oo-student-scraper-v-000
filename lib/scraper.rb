require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    i = 0
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".roster-cards-container .student-card").each do |student|
      students[i] = {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => student.css("a").attribute("href").value}
      i += 1

    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}

    doc.css(".social-icon-container a").each do |social|

        if social.attribute("href").value.split(".com").include?("https://twitter")
          student[:twitter] = social.attribute("href").value
        elsif social.attribute("href").value.split(".com").include?("https://www.linkedin")
          student[:linkedin] = social.attribute("href").value
        elsif social.attribute("href").value.split(".com").include?("https://github")
          student[:github] = social.attribute("href").value
        else
          student[:blog] = social.attribute("href").value

        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".description-holder p").text

      student

  end


end
