require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    scraped_student = [] 
    
    doc.css(".student-card").each do |x|
    student = {
      :name => x.css("h4").text, 
      :location => x.css("p").text,
      :profile_url => x.at_css("a")[:href]
    }
    scraped_student << student 
    end 
    scraped_student
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    sm = []
    att = {} 
    doc.css(".social-icon-container").css("a").each do |x|
          if x[:href].include? "twitter"
              att[:twitter] = x[:href]
            elsif x[:href].include? "linkedin"
              att[:linkedin] = x[:href]
            elsif x[:href].include? "github"
            att[:github] = x[:href]
          elsif x[:href].include? ""
            att[:blog] = x[:href] 
            att[:profile_quote] = doc.css(".profile-quote").text
            att[:bio] = doc.css(".description-holder").css("p").text 
          end 
             # binding.pry  
    end 
    att

    # att = {
    #   :profile_quote=> doc.css(".profile-quote").text,
    #   :bio=> doc.css(".description-holder").css("p").text 
    # }

  end

end 

