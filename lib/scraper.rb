require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.open(index_url)
    student_site = Nokogiri::HTML(html)

    student_index = []

    student_site.css("div.student-card").each do |student|
      student_index << {
        :name=> student.css("h4.student-name").text,
        :location=> student.css("p.student-location").text,
        :profile_url=> student.css("a").attr("href").value
      }
    end
    student_index
  end


  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}

    student[:bio] = doc.css("div.description-holder p").text
    student[:profile_quote] = doc.css("div.profile-quote").text

    doc.css("div.social-icon-container a").each do |profile|

      link = profile.attribute("href").value

      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
    student
  end

end
