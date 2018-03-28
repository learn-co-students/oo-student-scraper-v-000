require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("./fixtures/student-site/index.html")

    site = Nokogiri::HTML(html)
    # binding.pry
    students = []

    site.css(".student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
  end

    # :name site.css("h4.student-name").text
    # :location site.css("p.student-location").text
    # :profile_url site.css('div.student-card a').attribute("href").value

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    # binding.pry
    student_info = {}
    student.css(".social-icon-container a").each do |social|
      if social.attribute("href").value.match(/twitter/)
        student_info[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.match(/linkedin/)
        student_info[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.match(/github/)
        student_info[:github] = social.attribute("href").value
      else
        student_info[:blog] = social.attribute("href").value
      end
      student_info[:profile_quote] = student.css(".profile-quote").text
      student_info[:bio] = student.css(".description-holder p").text
    end
    student_info
  end

end
