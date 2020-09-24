require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_card = html.css(".student-card")

    student_array = []
    student_card.each do |card|
      student_hash = {}

      #student name
      student_hash[:name] = card.css(".student-name").text
      #student location
      student_hash[:location] = card.css(".student-location").text
      #profile URL
      student_hash[:profile_url] = card.css("a")[0]["href"]

      # insert into array
      student_array << student_hash
    end

    student_array

  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))

    profile_info = {}

    # socials (Twitter, LinkedIn, Github, blog)
    social_links = html.css(".social-icon-container")

    social_links.each do |link|
      link.css("a").each do |item|
        if item["href"].include? "twitter"
          profile_info[:twitter] = item["href"]
        elsif item["href"].include? "linkedin"
          profile_info[:linkedin] = item["href"]
        elsif item["href"].include? "github"
          profile_info[:github] = item["href"]
        else
          profile_info[:blog] = item["href"]
        end
      end
    end

    # profile quote
    profile_info[:profile_quote] = html.css(".profile-quote").text

    # bio
    bio_container = html.css(".bio-content.content-holder")
    profile_info[:bio] = bio_container.css("p").text

    profile_info
  end

end
