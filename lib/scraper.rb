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
        doc = Nokogiri::HTML(open(profile_url))
          profile = doc.css(".vitals-container").text
        s_hash =
        {
          :twitter => doc.css("div.class_name a").attr("href"),
          :linkedin =>  doc.css("div.class_name a").attr("href"),
          :github => doc.css("div.class_name a").attr("href"),
          :blog => doc.css("div.class_name a").attr("href")  ,
          :profile_quote => doc.css("div.profile-quote").text,
          :bio => doc.css("div.description-holder").text
        }
          # binding.pry

      end

    # end
end
