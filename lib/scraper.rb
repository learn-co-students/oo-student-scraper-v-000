require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    locations_array = []
    url_array = []
    names_array = []
    final_array = []
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
    
    ################# name #####################
    names = doc.css(".student-name")
    names.each do |item|
      names_array << item.text.strip
    end
    ####################################
  
    #############location#####################
    locations = doc.css(".student-location")
    locations.each do |item|
      locations_array << item.text.strip
    end
    #######################################
    
    x = 0
    y = names_array.length 
    
    while x < y 
      binding.pry
      temp_hash = Hash.new 
      temp_hash[:name] = "#{names_array[x - 1]}"
      temp_hash[:location] = "#{locations_array[x - 1]}"
      temp_hash[:profile_url] = ".students/#{names_array[x - 1]}.html"
      final_array << temp_hash
      x += 1
    end
    final_array
  end 

  def self.scrape_profile_page(profile_url)
    
  end

end

