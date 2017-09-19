require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      students = []
      page = Nokogiri::HTML(open(index_url))
      all_students = page.css(".roster-cards-container")
      all_students.each do |card|
        card.css(".student-card").each do |s|
          info = {}
          info[:name] = s.css(".student-name").text
          info[:location] = s.css(".student-location").text
          info[:profile_url] = s.css("a").first.attr('href')
          students << info
        end
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    links = {}
    page=Nokogiri::HTML(open(profile_url))
    all_links = page.css(".social-icon-container a").map {|single| single.attr('href')}
    all_links.each do |link|
          case
          when link.include?("twitter")
            links[:twitter] = link
          when link.include?("linkedin")
            links[:linkedin] = link
          when link.include?("github")
            links[:github] = link
          else
            links[:blog] = link
        end
      end
      links[:profile_quote] = page.css(".vitals-text-container .profile-quote").text
      links[:bio] = page.css(".description-holder p").text
      links
    end
end
