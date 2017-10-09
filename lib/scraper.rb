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
        profile = doc.css(".social-icon-container")
        twitter_link = student.css(".social-icon-container").href("src").value
        student = {
          :twitter=> twitter_link,
          :linkedin=>  "",
          :github=> "",
          :blog=> "",
          :profile_quote=> "",
          :bio=> ""
        }

        binding.pry
      end

    # end
end
