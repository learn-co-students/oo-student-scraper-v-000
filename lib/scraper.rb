require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_info = html.css("div.roster-cards-container").css(".student-card a") #gets basic student info

    student_info.map do |info|
      {:name => info.css("div.card-text-container h4").text, :location => info.css("div.card-text-container p").text, :profile_url => info['href']}
    end

  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    info = {}
    social = html.css("div.social-icon-container a").map{|links| links['href']}

    social.each do |link|
      if link.include?("twitter")
        info[:twitter] = link
      elsif link.include?("linkedin")
        info[:linkedin] = link
      elsif link.include?("github")
        info[:github] = link
      else info[:blog] = link
      end
    end

    info[:bio] = html.css("div.description-holder p").text
    info[:profile_quote] = html.css("div.profile-quote").text

    info

  end

end
