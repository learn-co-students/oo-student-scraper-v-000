require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".student-card").each do |page|
      link = page.at('a')
      student={ 
        :name => page.css("h4").text,
        :location =>page.css("p").text,
        :profile_url =>"http://students.learn.co/#{link.attributes["href"].value}"
        }
      students << student
       end
    students  
  end

  def self.scrape_profile_page(profile_url)
    profile_page =  Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container a").collect { |link| link['href'] } 
    profile ={  
      :twitter => links[0], 
      :linkedin => links[1], 
      :github => links[2],
      :blog => links[3],
      :profile_quote => profile_page.css(".profile-quote").text,
      :bio => profile_page.css(".description-holder p").text
        }
    
    return profile
    
  end

end

