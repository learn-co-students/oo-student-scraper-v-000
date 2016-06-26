require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :info

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container .student-card").map do |student|
      {:name => student.css(".card-text-container .student-name").text, 
       :location => student.css(".card-text-container .student-location").text,
       :profile_url => "http://127.0.0.1:4000/#{student.xpath('a/@href')}"
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = profile.css('.social-icon-container')
    
    links = social_links.xpath('a/@href').each do |link| 
      if link.value.include?('twitter')
      	student[:twitter] = link.value
      elsif link.value.include?('linkedin')
      	student[:linkedin] = link.value
      elsif link.value.include?('github')
      	student[:github] = link.value
      else
      	student[:blog] = link.value
      end
    end
    
    student[:profile_quote] = profile.css('.profile-quote').text
    student[:bio] = profile.css('.description-holder p').text
 

    return student
  end

end

