require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  index_url = "./fixtures/student-site/index.html"

  def self.scrape_index_page(index_url)

      website = Nokogiri::HTML(open(index_url))

      student_hash = {}
      students = []

      website.css("div.student-card").each do |student|
        student_hash = {
          :location => student.css("p.student-location").text,
          :name => student.css("h4.student-name").text,
          :profile_url => student.css("a").attribute("href").value,
        }
        students << student_hash
        #binding.pry
      end
      students
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    student_profile = {}

    social_links = profile.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      social_links.each do |link|
        if link.include?("twitter")
          student_profile[:twitter] = link
        elsif link.include?("linkedin")
          student_profile[:linkedin] = link
        elsif link.include?("github")
          student_profile[:github] = link
        elsif link.include?(".com")
          student_profile[:blog] = link
        end
      end
      student_profile[:profile_quote] = profile.css("div.profile-quote").text
      student_profile[:bio] = profile.css("div.description-holder p").text
      student_profile
  end

end
