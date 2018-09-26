require 'open-uri'
require 'pry'


class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        name = student.css(".card-text-container h4").text
        location = student.css("p.student-location").text
        profile_url = student.css("a").attr("href").text
        scraped_students << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
   scraped_students 
  end
  
  

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div.social-icon-container").each do |sociallink|
      card.css(".student-card").each do |student|
        twitter_url = student.css(".card-text-container h4").text
        linkedin_url = student.css("p.student-location").text
        github_url = student.css("a").attr("href").text
        blog_url =
        profile_quote =
        bio =
        
        scraped_students << {
          :twitter_url => twitter_url, 
          :linkedin_url => linkedin_url, 
          :github_url => github_url, 
          :blog_url => blog_url, 
          :profile_quote => profile_quote, 
          :bio => bio
         }
      end
    end
   scraped_students 
  end

end

