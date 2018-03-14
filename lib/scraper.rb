require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      scraped_students = []
      doc = Nokogiri::HTML(open(index_url))
      student_cards = doc.css(".student-card")
      student_cards.each do |student_card|
          student_hash = Hash.new
          student_hash[:name] = student_card.css(".student-name").text
          student_hash[:location] = student_card.css(".student-location").text
          local_link = student_card.css("a").attribute("href").value
          student_hash[:profile_url] = local_link
          scraped_students << student_hash
      end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_profile = Hash.new
    social_items = doc.css(".social-icon-container a")
    #find twitter link
    twitter_element = social_items.find {|s| s.css("img").attribute("src").value == "../assets/img/twitter-icon.png"}
    if twitter_element
        scraped_profile[:twitter] = twitter_element.attribute("href").value
    end
    
    #find linkedin element
    linkedin_element = twitter_element = social_items.find {|s| s.css("img").attribute("src").value == "../assets/img/linkedin-icon.png"}
    if linkedin_element
        scraped_profile[:linkedin] = linkedin_element.attribute("href").value
    end
    
    #find github element
    github_element = social_items.find {|s| s.css("img").attribute("src").value == "../assets/img/github-icon.png"}
    if github_element
        scraped_profile[:github] = github_element.attribute("href").value
    end
    
    #find blog element
    blog_element = social_items.find {|s| s.css("img").attribute("src").value == "../assets/img/rss-icon.png"}
    if blog_element
        scraped_profile[:blog] = blog_element.attribute("href").value
    end
    
    scraped_profile[:bio] =  doc.css(".bio-content .description-holder").text.strip
    scraped_profile[:profile_quote] = doc.css(".profile-quote").text
    scraped_profile
  end

end

