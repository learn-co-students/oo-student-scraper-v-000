require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profile_cards = Nokogiri::HTML(open(index_url))

    student_cards = []

    profile_cards.css("div.student-card").each do |card|
      student_cards << {
        :name => card.css("div.card-text-container h4.student-name").text,
        :location => card.css("div.card-text-container p.student-location").text,
        :profile_url => index_url + card.css("a").attribute("href").value.to_s

      }
    end
    student_cards     
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))

    student_info = {}

    student_profile.css(".profile").each do |profile|
      
    # socials - twitter url, linkedin url, github url, blog url, 
     social_links = profile.css(".vitals-container .social-icon-container").children.css("a").collect { |atag| atag.attribute('href').value }
       social_links.each do |link|
          if link.include?("twitter")
            student_info[:twitter]=link
          elsif link.include?("linkedin") 
            student_info[:linkedin]=link
          elsif link.include?("github")    
            student_info[:github]=link
          else
            student_info[:blog]=link
          end
        end
      # profile quote and bio
      student_info[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text
      student_info[:bio] = profile.css(".details-container .description-holder p").text
    end
    student_info
  end

end

