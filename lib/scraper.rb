require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

#when we scrape we have two loops going. The first loop moves the operations to different students (in the roster-cards-container)
#the second loop is iterating within each student to grab the name, location and profile_url

  def self.scrape_index_page(index_url)
    html=File.read('./fixtures/student-site/index.html')
    index = Nokogiri::HTML(html)
    scraped_students = []

    index.css("div.roster-cards-container").each do |students|
      students.css("div.student-card").each do |student|
        scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attr('href').value
      }
    end
  end
  scraped_students
end

  def self.scrape_profile_page(profile_url)
    #html=File.read("#{profile_url}")
    html=File.read('./fixtures/student-site/students/adam-fraser.html')
    profile = Nokogiri::HTML(html)
    profile_page = {}

      profile.css("div.main-wrapper.profile").each do |attribute|

        profile_page = {
        :twitter=> attribute.css("div.social-icon-container a")[0].attr("href"),
        :linkedin=> attribute.css("div.social-icon-container a")[1].attr("href"),
        :github=>attribute.css("div.social-icon-container a")[2].attr("href"),
        :blog=>attribute.css("div.social-icon-container a")[3].attr("href"),
        :profile_quote=> attribute.css("div.profile-quote").text,
        :bio=> attribute.css("div.description-holder p").text
      }

    end
    profile_page
  end



end
