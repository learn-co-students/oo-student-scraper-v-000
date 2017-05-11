require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".student-card")

    student_cards.collect do |student|
      {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attr("href").text
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css("div.social-icon-container a")

    profile_hash = {}


    social_links.each do |link|
      link = link.attr("href")

      if link.include?("twitter")
        profile_hash[:twitter] = link
      elsif link.include?("github")
        profile_hash[:github] = link
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link
      else
        profile_hash[:blog] = link
      end
    end

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".bio-content p").text

    profile_hash
  end
end
