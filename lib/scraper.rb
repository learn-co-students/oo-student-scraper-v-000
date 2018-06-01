require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open("fixtures/student-site/index.html"))
    student_card = doc.css(".student-card")
    array = []
    student_card.each do |student|
      array << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      }

      end
      array
    end


    def self.scrape_profile_page(profile_url)

      doc = Nokogiri::HTML(open("fixtures/student-site/students/ryan-johnson.html"))
        binding.pry
    end

end
