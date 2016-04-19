require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    student_cards = doc.css('.student-card')
    
    student_cards.each do |card|
      name = card.css('h4').text
      location = card.css('.student-location').text
      url = card.css('a').attribute('href').value
      
      scraped_students << {
        :name         => name, 
        :location     => location, 
        :profile_url  => index_url + url
      }
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_path = '.vitals-container div.social-icon-container a'
    social_accounts = doc.css(social_path)  
    social_urls = social_accounts.map do |account|
      account.attribute('href').value
    end    
    
    quote_path = '.vitals-container div.vitals-text-container div.profile-quote'
    profile_quote = doc.css(quote_path).text
    
    bio_path = '.details-container div.bio-content div.description-holder p'
    bio = doc.css(bio_path).text
    
    data = {
      :social         => social_urls, 
      :profile_quote  => profile_quote,
      :bio            => bio
    }

    student_hasher(data)
  end
  
  private
  def self.student_hasher(data)
    scraped_student = {}
    
    data[:social].each do |url|
      (scraped_student[:twitter] = url; next) if url.include? 'twitter'
      (scraped_student[:linkedin] = url; next) if url.include? 'linkedin'
      (scraped_student[:github] = url; next) if url.include? 'github'
      scraped_student[:blog] = url
    end

    scraped_student[:profile_quote] = data[:profile_quote]
    scraped_student[:bio] = data[:bio]
    
    scraped_student
  end
  
end
