require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

        doc = Nokogiri::HTML(open(index_url))
        students = []

            doc.css('.student-card').each do |student|
              url = student.css('a').attribute('href').value
                  students <<  {

                    name: student.css(".student-name").text, 
                    location: student.css(".student-location").text, 
                    profile_url: "#{index_url}#{url}" 
                    }
            end  
        students
    
  end

  def self.scrape_profile_page(profile_url)
    

      doc = Nokogiri::HTML(open(profile_url))

      binding.pry



  end

end

