require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
		url = Nokogiri::HTML(open(index_url))
		url.css('.roster-body-wrapper .roster-cards-container .student-card').collect do |student|
			{
				name: student.css('a .card-text-container h4.student-name').text,
				location: student.css('a .card-text-container p.student-location').text,
				profile_url: student.css('a').attribute('href').value
			}
		end	
  end

  def self.scrape_profile_page(profile_url)

    
  end

end #. End of Class

# index_url = Nokogiri::HTML(open('http://127.0.0.1:8080/'))
# index_url = 'http://127.0.0.1:8080/'