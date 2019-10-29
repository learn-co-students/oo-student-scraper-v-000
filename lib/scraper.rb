require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    locations_array = []
    url_array = []
    names_array = []
    final_array = []
    #html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    html = open("#{index_url}")
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
    y = names_array.length - 1
    
    while x < y  
      temp_hash = Hash.new 
      temp_hash[:name] = "#{names_array[x]}"
      temp_hash[:location] = "#{locations_array[x]}"
      z = names_array[x].split(" ")
      #temp_hash[:profile_url] = "students/#{names_array[x]}.html"
      temp_hash[:profile_url] = "students/#{z[0]}-#{z[1]}.html".downcase
      final_array << temp_hash
      x += 1
    end
    final_array
  end 

  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)
    tree = doc.css(".social-icon-container")
    
    temp_hash = Hash.new
    temp_hash[:twitter] = tree.children[0] 
    binding.pry
  end

end

