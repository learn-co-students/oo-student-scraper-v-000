require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(url)
    html = File.read(url)
    index = Nokogiri::HTML(html)
    students = {}
    index.css('div.student-card').each do |student|
        
    students = {
    :name => student.css('h4.student-name').text,
    :location => student.css("p.student-location").text,
      binding.pry
    :profile_url => student.css('div.student-card a').map { |link| link['href'] }
      }
          end
    end
    # students
    # end


  def self.scrape_profile_page(profile_url)
    
  end

end

