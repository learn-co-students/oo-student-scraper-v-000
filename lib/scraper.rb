require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper
  

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    
    student_list = []
    
    
    doc.css(".roster-cards-container").css(".student-card").each do |item|
      student = {}
      
      student[:name] = item.css(".student-name").children.map{|name| name.text}.compact[0]
  
      student[:location] = item.css(".student-location").children.map{|location| location.text}.compact[0]
      
      student[:profile_url] = item.css('a').map { |a| a['href']}.flatten[0] unless item.css('a').nil?
      
      student_list << student
      
    end
   
    student_list
  end
  
    
  

  def self.scrape_profile_page(profile_url)
      
      page = Nokogiri::HTML(open(profile_url))
      
    
        profile = {}
        page.css(".vitals-container").css(".social-icon-container").css('a').map do |a|
        
            link =  a['href'] unless a.nil?
            
            key = self.get_host_without_www(link)
            
            unless ["linkedin", "twitter", 'facebook', 'github'].include? key
              profile[:blog] = link
            else
              profile[key.to_sym] = link
            end
            
        end
  
        profile[:profile_quote] = page.css(".vitals-container").css(".vitals-text-container").css(".profile-quote").text
        
        profile[:bio] = page.css(".details-container").css(".description-holder")[0].css('p').text
        
        profile
  end
  
  def self.get_host_without_www(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase.split('.').first(2)
    host[0] == 'www' ? host[1] : host[0]
  end
  
end

