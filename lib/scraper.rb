require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scrape = Nokogiri::HTML(open(index_url))
    scraped_students = []
    scrape.css("div.roster-cards-container").each do |container|
      container.css("div.student-card").each do |student|
        student = {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => "./fixtures/student-site/#{student.css("a").attr("href")}"
        }
        scraped_students << student
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scrape = Nokogiri::HTML(open(profile_url))
    student = {}
    profile = scrape.css("div.social-icon-container a").map {|e| e.attr("href")}
      profile.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        else 
          student[:blog] = link
        end
      end
      student[:profile_quote] = scrape.css("div.profile-quote").text
       student[:bio] = scrape.css("div.bio-content.content-holder div.description-holder p").text

       student
  end
end

