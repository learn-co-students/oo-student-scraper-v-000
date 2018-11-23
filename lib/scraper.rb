require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "#{student.attr('href')}"
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = []

    links = profile_page.css("div.vitals-container").each do |element|
      element.css
    twitter_url:
    linkedin_url:
    github_url:
    blog_url:
    profile_quote:
    bio:

  end

  def self.scrape_profile_page(profile_slug)
   student = {}
   profile_page = Nokogiri::HTML(open(profile_slug))
   links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
   links.each do |link|
     if link.include?("linkedin")
       student[:linkedin] = link
     elsif link.include?("github")
       student[:github] = link
     elsif link.include?("twitter")
       student[:twitter] = link
     else
       student[:blog] = link
     end
   end

end
