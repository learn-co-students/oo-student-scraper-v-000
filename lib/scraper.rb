require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_webpage = Nokogiri::HTML(html)
    student_info = [] 
    #my_array << {:residential => "false"}
    learn_webpage.css().each do |student|
      name = student.css().text 
      location = student.css().text 
    end
    learn_webpage.css(). each do |student|
      profile_url = student.css().text 
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

