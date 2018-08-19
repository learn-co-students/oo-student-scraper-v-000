require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    results = Nokogiri::HTML(open(index_url))
    students = []
    results.css("div.roster-cards-container").each do |card|
        card.css("div.student-card").each do |student|
          name = student.css("h4.student-name").text
          location = student.css("p.student-location").text
          profile_url = student.css("a").attribute("href").value
          students << {:name => name, :location => location, :profile_url => profile_url}
        end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    scraped_student[:profile_quote] = profile.css("div.profile-quote").text
    profile.css("div.social-icon-container").children.css("a").map do |link|
      check = link.attribute("href").value
      if check.match(/twitter/)
        scraped_student[:twitter] = check
      elsif check.match(/linkedin/)
        scraped_student[:linkedin] = check
      elsif check.match(/github/)
        scraped_student[:github] = check
      elsif profile.css("div.social-icon-container a").children.count == 4
        scraped_student[:blog] = check
      else
      end
    end
    profile.css("div.details-container").each do |block|
      block.css("div.bio-content.content-holder").each do |bio|
        bio = bio.css("p").text
        scraped_student[:bio] = bio
      end
      end
    scraped_student
  end


end
