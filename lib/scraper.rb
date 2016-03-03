require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :page_url, :index
 
  def initialize(page_url)
    @page_url=page_url
  end



  def self.scrape_index_page(index_url)
    scraped_students=[]
    student_hash={}
    doc= Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
       student_hash = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
    }
      scraped_students<<student_hash
    end
    
    scraped_students
  end

    
  

  def self.scrape_profile_page(profile_url)
    personal_info_hash={}
    profile= Nokogiri::HTML(open(profile_url))
    profile.css("div.social-icon-container a").each do |social|
      if social.attribute("href").value.to_s.include?("twitter")
        personal_info_hash[:twitter]=social.attribute("href").value
       elsif social.attribute("href").value.to_s.include?("github")
        personal_info_hash[:github]=social.attribute("href").value 
      elsif social.attribute("href").value.to_s.include?("linkedin")
        personal_info_hash[:linkedin]=social.attribute("href").value
      elsif social.css("img.social-icon").attribute("src").value.to_s.include?("rss-icon")
        personal_info_hash[:blog]=social.attribute("href").value
      end
    end
    personal_info_hash[:profile_quote]= profile.css(".profile-quote").text
    personal_info_hash[:bio]= profile.css("div.description-holder p").text

    personal_info_hash  
    
  end

end
#Scraper.scrape_index_page(../fixtures/student-site/index.html)

# student: @doc.css(".student-card")
# name: @doc.css
# location: @doc.css(".student-location").first.text
# links: links= @doc.css(".student-card a")
# links: links[0]["href"]
# social ("div.social-icon-container").attributes("href").value
# :twitter
# :linkedin
# :github
# :blog
# :profile_quote
# :bio