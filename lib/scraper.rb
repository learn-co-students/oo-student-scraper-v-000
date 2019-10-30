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
    binding.pry
    final_array = []
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)
    ####################HTMLs##########################################
    nodeset = doc.xpath('//div[@class="social-icon-container"]/a/@href')
    nodeset.each do |item|
      final_array << item.value
    end
    ###################################################################
    
    ####################text#####################################
    
    temp_hash = Hash.new
    temp_hash[:twitter] = "#{final_array[0]}"
    temp_hash[:linkedin] = "#{final_array[1]}"
    temp_hash[:github] = "#{final_array[2]}"
    temp_hash[:blog] = "#{final_array[3]}"
    ###############################################
    temp_hash[:profile_quote] = "#{}"
    temp_hash[:bio] = "#{}"
    
    
    final_array
      
    #nodeset.first.value
    #x = 4
    #while x > 0
    
    #x -= 1
    
    

 
#To find a link within the <div id="block2">

#nodeset = doc.xpath('//div[@id="block2"]/a/@href')
#nodeset.first.value # => "http://stackoverflow.com"

#nodeset = doc.css('div#block2 a[href]')
#nodeset.first['href'] # => "http://stackoverflow.com"
    
    
    #nodeset.map {|element| element["href"]}.compact
    
    #tree = doc.css(".social-icon-container")
    
    #temp_hash = Hash.new
    #temp_hash[:twitter] = tree.children[0] 
  end
  
  #nodeset.map {|element| element["href"]}.compact

end

