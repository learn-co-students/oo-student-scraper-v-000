require'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
#scrapes the student index page ('./fixtures/student-site/index.html') and #and returns an array of hashes in which each hash represents one stude
  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |profile|
      scraped_students << {
        :name => profile.css("h4").text,
        :location => profile.css("p").text,
        :profile_url => profile.css("a").attribute("href").value
      }
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
      scraped_profiles = {}
      doc = Nokogiri::HTML(open(profile_url))
      links = doc.css("div.social-icon-container").children.css("a").map do |url|
        url.attribute("href").value
      end
      links.each do |link|
        if link.include?("twitter")
          scraped_profiles[:twitter] = link
        elsif link.include?("linkedin")
          scraped_profiles[:linkedin] = link
        elsif link.include?("github")
          scraped_profiles[:github] = link
        else
          scraped_profiles[:blog] = link
        end
      end
      quote = doc.css("div.profile-quote").text
      scraped_profiles[:profile_quote] = quote
      bio = doc.css(".bio-content").children.css("p").text
      scraped_profiles[:bio] = bio
      scraped_profiles
    end

  end
