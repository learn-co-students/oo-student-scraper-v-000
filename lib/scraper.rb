require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    doc.css(".student-card").each do |card|
      student_array << {:name => card.css(".card-text-container .student-name").text, :location => card.css(".card-text-container .student-location").text, :profile_url => card.css("a")[0]["href"]}
    end
    
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    social_links = doc.css(".social-icon-container a")
    
    social_links.each_with_index do |link, index|
      if link["href"].include?("twitter.com")
        student_profile[:twitter] = link["href"]
      end
      if link["href"].include?("linkedin.com")
        student_profile[:linkedin] = link["href"]
      end
      if link["href"].include?("github.com")
        student_profile[:github] = link["href"]
      end
      if link.css(".social-icon").to_s.include?("rss-icon")
         student_profile[:blog] = link["href"]
      end
    end
    
    student_profile[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_profile[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
    
    student_profile
  end

end

