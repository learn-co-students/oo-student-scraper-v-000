require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = []
    roster.css(".student-card").each do |student_card|
  
    students << {
      :name => student_card.css(".student-name").text,
      :location => student_card.css(".student-location").text,
      :profile_url => student_card.css("a").attribute("href").value
    }
    
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student_profile = []
    profile_page.css(".profile").each do |div|
      # binding.pry
      twitter = div.css(".social-icon-container a[href*='twitter']").attribute("href").value
      linkedin = div.css(".social-icon-container a[href*='linkedin']").attribute("href").value
      github = div.css(".social-icon-container a[href*='github']").attribute("href").value
      profile_quote = div.css(".profile-quote").text
      bio = div.css(".bio-content description-holder").text
      

      student_profile << {
        # :twitter => twitter unless twitter != undefined,
        # :linkedin => linkedin unless linkedin != undefined,
        # :github => github unless github != undefined,
        :profile_quote => profile_quote,
        :bio => bio
      }
    end
    
    
  end
  
  # self.scrape_index_page("./fixtures/student-site/index.html")

end

