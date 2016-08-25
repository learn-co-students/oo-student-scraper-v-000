require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_index = []

    doc.css("div.student-card").each do |student_card|
      student = {
        :name => student_card.css("h4.student-name").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/" + student_card.css("a").attribute("href").value
      }
      student_index << student
    end
    student_index

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    doc.css("div.social-icon-container a").each do |student|




      if  student.attribute("href").value.include?("twitter")
        student_profile[:twitter] = student.attribute("href").value

      elsif student.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = student.attribute("href").value

      elsif student.attribute("href").value.include?("github")
      student_profile[:github] = student.attribute("href").value

      else student.attribute("href").value.include?("blog")
        student_profile[:blog] = student.attribute("href").value

      end
    end

    student_profile[:bio] = doc.css("div.bio-content p").text

    student_profile[:profile_quote] = doc.css("div.profile-quote").text

     student_profile



  end

end
