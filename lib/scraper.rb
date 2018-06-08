require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
  
    index.css('div.student-card').each do |student|
      student = {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    attributes = {}
    social_link = html.css('div.social-icon-container')
    
    link_index = 0
    
    if social_link.css('a')[link_index]
      scraped_link = social_link.css('a')[link_index].attribute('href').value
      if scraped_link.include?('twitter')
        attributes[:twitter] = social_link.css('a')[link_index].attribute('href').value
        link_index += 1 
      end
    end
    
    if social_link.css('a')[link_index]
      scraped_link = social_link.css('a')[link_index].attribute('href').value
      if scraped_link.include?('linkedin')
        attributes[:linkedin] = social_link.css('a')[link_index].attribute('href').value
        link_index += 1
      end
    end
   
    if social_link.css('a')[link_index]
      scraped_link = social_link.css('a')[link_index].attribute('href').value
      if scraped_link.include?('github')
        attributes[:github] = social_link.css('a')[link_index].attribute('href').value
        link_index += 1
      end
    end
    
    if social_link.css('a')[link_index]
      attributes[:blog] = social_link.css('a')[link_index].attribute('href').value
    end
    
    attributes[:profile_quote] = html.css('div.profile-quote').text
    attributes[:bio] = html.css('div.description-holder p').text
    
    attributes
    
  end

end

