require 'open-uri'
require 'pry'
require "nokogiri"


class Scraper

  def self.scrape_index_page(index_url) #responsible for scraping the index page that lists all of the students
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

      doc.css("div.student-card").each do |student|
        scraped_students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
  end
  scraped_students
end

  def self.scrape_profile_page(profile_url) #responsible for scraping an individual student's profile page to get further information
    profile_doc = Nokogiri::HTML(open(profile_url))
     #binding.pry
    student_profile = {}

      social = profile_doc.css("div.social-icon-container").children.css("a").collect {|link| link.attribute("href").value}

        social.each do |link|
          if link.include? ("twitter")
            student_profile[:twitter] = link
          elsif link.include? ("linkedin")
            student_profile[:linkedin] = link
          elsif link.include? ("github")
            student_profile[:github] = link
          else student_profile[:blog] = link
          end
        end

      student_profile[:profile_quote] = profile_doc.css("div.profile-quote").text if profile_doc.css("div.profile-quote").text
      student_profile[:bio] = profile_doc.css("div.bio-block p").text if profile_doc.css("div.bio-block p").text
  student_profile
end

end
