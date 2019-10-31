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
    final_array = []
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)
    nodeset = doc.xpath('//div[@class="social-icon-container"]/a/@href')
    nodeset.each do |item|
      final_array << item.value
    end
    temp_hash = Hash.new
    
    #########################
    
    final_array.each do |item|
      if item.include?("twitter")
        temp_hash[:twitter] = "#{item}"
        elsif item.include?("linkedin")
        temp_hash[:linkedin] = "#{item}"
        elsif item.include?("github")
        temp_hash[:github] = "#{item}"
        elsif item.include?("blog")
        temp_hash[:blog] = "#{item}"
      end
    end
    
    if 
    
    if final_array[0].include?("twitter")
      temp_hash[:twitter] = "#{final_array[0]}"
    end
    if final_array[1].include?("linkedin")
      temp_hash[:linkedin] = "#{final_array[1]}"
    end
    if final_array[2].include?("github")
      temp_hash[:github] = "#{final_array[2]}"
    end
    if final_array[3].include?("blog")
      temp_hash[:blog] = "#{final_array[3]}"
    end
    if !!doc.css(".profile-quote").text.scan(/[a-z]/)
      temp_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    end
    if doc.css('p').text.scan(/[a-z]/)
      temp_hash[:bio] = doc.css('p').text
    end
      
    #########################

    #temp_hash[:twitter] = "#{final_array[0]}"
    #temp_hash[:linkedin] = "#{final_array[1]}"
    #temp_hash[:github] = "#{final_array[2]}"
    #temp_hash[:blog] = "#{final_array[3]}"
    #temp_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    #binding.pry
    #temp_hash[:bio] = doc.css('p').text
    temp_hash
  end
end