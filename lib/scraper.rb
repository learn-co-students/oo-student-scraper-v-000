require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    roster_card = []
    index_page.css("div.roster-cards-container").each do |students|
      students.css("div.student-card a").each do |info|
        roster_hash = {
        :name => info.css(".student-name").text,
        :location => info.css(".student-location").text,
        :profile_url => "#{info.attr('href')}"
      }
      roster_card << roster_hash
        end
      end
      roster_card
     end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_page = Nokogiri::HTML(html)
    roster = {}
    # student_page.css("div.vitals-container").each do |social|
        #iterates over each <a href> and set it to a variable= to just the scraped link
        social_media = student_page.css(".social-icon-container a")
        #iterate over each link to see if the site contains the specific word
          social_media.each do |link|
            if link.attr('href').include?("linkedin")
              roster[:linkedin] = link.attr("href")
            elsif link.attr('href').include?("twitter")
              roster[:twitter] = link.attr("href")
            elsif link.attr('href').include?("github")
              roster[:github] = link.attr("href")
            else
              roster[:blog] = link.attr("href")
             end
          end

         roster[:profile_quote] = student_page.css(".profile-quote").text
         roster[:bio] = student_page.css("div.description-holder p").text

         roster
     end

end
