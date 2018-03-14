require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

    def self.scrape_index_page(index_url)
      students = []
      doc = Nokogiri::HTML(open(index_url))
      students_data = doc.css(".student-card a")
      students_data.each do |student|
        profile_link = student.attr('href')
        profile_name = student.css(".student-name").text
        profile_place = student.css(".student-location").text

        student_hash = {
          :name => profile_name,
          :location => profile_place,
          :profile_url => profile_link
        }
        students << student_hash

      end
      students
    end

      def self.scrape_profile_page(profile_url)
          student = {}
          doc = Nokogiri::HTML(open(profile_url))
          links = doc.css(".social-icon-container").children.css("a").map { |l| l.attribute('href').value }
          links.each do |link|
           if link.include?("twitter")
             student[:twitter] = link
           elsif link.include?("linkedin")
             student[:linkedin] = link
           elsif link.include?("github")
             student[:github] = link
           else
             student[:blog] = link
           end
         end
        
         student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
         student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    student
  end
end
