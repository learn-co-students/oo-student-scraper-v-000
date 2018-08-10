require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper
  

  def self.scrape_index_page(index_url)
    url = './fixtures/student-site/index.html'
    doc = Nokogiri::HTML(open(url))
    
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
      # profile_url = './fixtures/student-site/students/ann-lee.html'
      page = Nokogiri::HTML(open(profile_url))
      
    # <div class="profile-banner" id="aaron-enser-cover"></div>
    #   <div class="vitals-container">
    #     <div class="profile-photo" id="aaron-enser-card"></div>
    #     <div class="social-icon-container">
    #       <a href="http://www.github.com/aenser"><img class="social-icon" src="../assets/img/github-icon.png"/></a>
    #       <a href="https://www.linkedin.com/in/aaron-enser-96a756a6"><img class="social-icon" src="../assets/img/linkedin-icon.png"/></a>
    #       <a href="https://facebook.com/aaronenser"><img class="social-icon" src="../assets/img/facebook.png"/></a>
    #     </div>
    #     <div class="vitals-text-container">
    #       <h1 class="profile-name">Aaron Enser</h1>
    #       <h2 class="profile-location">Scottsdale, AZ</h2>
    #       <div class="profile-quote">“When you realize there is nothing lacking, the whole world belongs to you." -Lao Tzu"</div>
    #     </div>
    #   </div>
    #   <div class="details-container">
    #     <div class="bio-block details-block">
    #       <div class="bio-content content-holder">
    #         <div class="title-holder">
    #           <h3>Biography</h3>
    #         </div>
    #         <div class="description-holder">
    #           <p>I love traveling, new experiences, meeting new people, reading, languages, and now coding.</p>
    #         </div>
    #       </div>
    #     </div>
        profile = {}
        page.css(".vitals-container").css(".social-icon-container").each do |item|
        
      
            link = item.css('a').map { |a| a['href']}.flatten[0] unless item.css('a').nil?
            
            key = self.get_host_without_www(link)
            
            if key == page.css(".vitals-text-container").css(".profile-name").text.gsub(/\s+/, '').downcase
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
  
  puts self.get_host_without_www("https://github.com/aplee29")
  puts Nokogiri::HTML(open('./fixtures/student-site/students/ann-lee.html')).css(".vitals-text-container").css(".profile-name").text.gsub(/\s+/, '').downcase
  puts Nokogiri::HTML(open('./fixtures/student-site/students/ann-lee.html')).css(".details-container").css(".description-holder")[0].css('p').text
end

