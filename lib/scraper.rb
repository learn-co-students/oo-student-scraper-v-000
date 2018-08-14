require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    html = (open("http://165.227.31.208:52075/fixtures/student-site/"))
    doc = Nokogiri::HTML(html)
    profile = doc.css(".student-card")
      profile.each do |data|
        name = data.css('.card-text-container .student-name').text
          binding.pry
      end



    # profiles = doc.css(".student-card .card-text-container").text
    # names = doc.css(".student-card .card-text-container .student-name").text
    # locations = doc.css(".student-card .card-text-container .student-location").text
    # url = doc.css('.student-card a').first.attribute('href').value



  end

  def self.scrape_profile_page(profile_url)

  end

end
