require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_webpage = Nokogiri::HTML(html)
    @student_info = [] 
    learn_webpage.css().each do |student|
      name = student.css().text
      @student_info << {:name => name}
      location = student.css().text
      @student_info[:location] = location 
    end
    learn_webpage.css(). each do |student|
      profile_url = student.css().text 
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

