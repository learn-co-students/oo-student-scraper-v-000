require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  

  def self.scrape_index_page(index_url)
    html = self.get_html(index_url)
    
    students = []
    html.css("div.student-card").each do |student|
      students << {
        :name => student.css("a div.card-text-container h4.student-name").text, 
        :location => student.css("a div.card-text-container p.student-location").text, 
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value.downcase}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = self.get_html(profile_url)
    
    student = {
      :profile_quote => html.css("div.profile-quote").text.strip,
      :bio => html.css("div.bio-content div.description-holder").text.gsub(/\n/, "").strip
    }
    
 #  social_links = []
 #  html.css(".social-icon-container a").each do |a|
 #    social_links << a.attribute("href").value
 #  end

 #  social_keys = []
 #  html.css(".social-icon-container a img").each do |img|
 #    social_keys << img.attribute("src").value.sub("../assets/img/", "").chomp!("-icon.png")
 #  end
 #  
 #  social_keys.collect! do |key|
 #    key == "rss" ? key = "blog" : key
 #  end

      social_links = self.get_social_links(html)
 
      social_keys = self.get_social_keys(html)
      
      counter = 0
      while counter < social_keys.size
        begin
          student[social_keys[counter].to_sym] = social_links[counter]
          rescue NoMethodError
          end
          counter += 1
      end
    
    
    student
        
  end
  
  ## helper for both
  
  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end
 
  ## helpers for #scrape_profile_page
  
  def self.get_social_links(html)
    social_links = []
    html.css(".social-icon-container a").each do |a|
      social_links << a.attribute("href").value
    end
    social_links
  end
  
  def self.get_social_keys(html)
    social_keys = []
    html.css(".social-icon-container a img").each do |img|
        social_keys << img.attribute("src").value.sub("../assets/img/", "").chomp!("-icon.png")
    end
    
    social_keys.collect! do |key|
      key == "rss" ? key = "blog" : key
    end
    
    social_keys
  end

end



