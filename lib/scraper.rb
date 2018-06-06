require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    names = doc.css(".student-name") 
    locations = doc.css(".student-location")
    student_url = doc.css(".student-card a[href]")
  
    name_array = names.collect{|name| name.text}
    location_array = locations.collect{|loc| loc.text}
    url_array = student_url.collect{|url| url["href"]}
    
    counter = 0 
    student_array = []
    
    name_array.each do |name|
      student_array << {name: name, location: location_array[counter], profile_url: url_array[counter]}
        counter += 1
    end 
    student_array
  end

  def self.scrape_profile_page(profile_url)
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    student_social = {}
    
    doc.css("div.main-wrapper.profile .social-icon-container a").each do |icon|
      if icon.attribute("href").value.include?("twitter")
       student_social[:twitter] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("linkedin")
       student_social[:linkedin] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("github")
       student_social[:github] = icon.attribute("href").value
      else 
       student_social[:blog] = icon.attribute("href").value
      end 
    end
    student_social[:profile_quote] = doc.css(".profile-quote").text
    student_social[:bio] = doc.css(".description-holder p").text
    
    student_social

end
end
