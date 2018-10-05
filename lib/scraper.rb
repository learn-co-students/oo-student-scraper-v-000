require 'open-uri'
require 'pry'
require 'Nokogiri'

class Scraper

  def self.scrape_index_page(url)
    html = File.read(url)
    index = Nokogiri::HTML(open(html))
    students = {}
    
    index.css('div.student-card').each do |student|
      students = {
    :name => student.css('h4.student-name').text,
    :location => student.css("p.student-location").text,
    :profile_url => student.css("a href").text
      }
        binding.pry
      end
    end
    # students
    # end


  def self.scrape_profile_page(profile_url)
    
  end

end

