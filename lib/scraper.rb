require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    rtn = []

    page = Nokogiri::HTML(open(index_url))
    cards = page.css(".student-card")
    cards.each do |card|
      add = {}
      add[:name] = card.css(".student-name").text
      add[:location] = card.css(".student-location").text
      add[:profile_url] = card.css("a").attribute('href').to_s
      rtn << add if !!add[:name]
      #binding.pry
    end
    rtn
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    
    page = Nokogiri::HTML(open(profile_url))
    page.xpath('//div[@class="social-icon-container"]/a').map do |profile|
      if profile['href'].include?("twitter")
        scraped_student[:twitter] = profile['href']
      elsif profile['href'].include?("linkedin")
        scraped_student[:linkedin] = profile['href']
      elsif profile['href'].include?("github")
        scraped_student[:github] = profile['href']
      #binding.pry
      else 
        scraped_student[:blog] = profile['href']
    
      end
    end
    scraped_student[:profile_quote] = page.css(".profile-quote").text
    scraped_student[:bio] = page.css(".description-holder p").text
    scraped_student
    #binding.pry
  end

end

