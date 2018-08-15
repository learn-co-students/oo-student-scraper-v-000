require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
  #  html = (open("http://165.227.31.208:57678/fixtures/student-site/"))
    html = (open(index_url))
    doc = Nokogiri::HTML(html)
    student_profiles = []
    student_info = doc.css(".student-card")
      student_info.collect do |profile|
          student_profile = {}
          student_profile[:name] =  profile.css('.card-text-container .student-name').text
          student_profile[:location] = profile.css('.card-text-container .student-location').text
          student_profile[:profile_url] = profile.css('a').first.attribute('href').value

          student_profiles << student_profile
        end
        student_profiles
        #binding.pry
      end

  def self.scrape_profile_page(profile_url)

  end

end
