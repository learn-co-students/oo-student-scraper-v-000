require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    
    scraped_students = []
    
    index_page.css('div.student-card').each do
      
      |student_card|
      student_name = student_card.css('h4.student-name').text 
      student_location = student_card.css('p.student-location').text
      student_profile = student_card.css('a').attribute('href').value
      
      scraped_students << {
        :name => student_name,
        :location => student_location,
        :profile_url => student_profile
      }
      
      end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    # binding.pry
    profile_page = Nokogiri::HTML(File.read(profile_url))
    
    profile_hash = {}
    
    profile_hash[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder").text.strip

    profile_page.css("div.vitals-container").each do
    |student_info|
      
      profile_hash[:profile_quote] = student_info.css("div.profile-quote").text.strip
      
      student_info.css("div.social-icon-container a").each do
        |social_acct|
        
        if social_acct.attribute("href").value.include?('twitter')
          profile_hash[:twitter] = social_acct.attribute("href").value
        elsif social_acct.attribute("href").value.include?('linkedin')
          profile_hash[:linkedin] = social_acct.attribute("href").value
        elsif social_acct.attribute("href").value.include?('github')
          profile_hash[:github] = social_acct.attribute("href").value
        else
          profile_hash[:blog] = social_acct.attribute("href").value
        end
      end
    end
    profile_hash
  end
end

