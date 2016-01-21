require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    scraped_students = []

    html.css("div.student-card").each do |student|
      scraped_students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/" + student.css("a").attribute("href").value
        }
    end  
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}

    html.css(".social-icon-container a").each do |link|
      scraped_profile[:linkedin] = link.attribute("href").value if link.attribute("href").value.include?("linkedin")
      scraped_profile[:twitter] = link.attribute("href").value if link.attribute("href").value.include?("twitter")
      scraped_profile[:github] = link.attribute("href").value if link.attribute("href").value.include?("github")
      scraped_profile[:blog] = link.attribute("href").value if link.css("img").attribute("src").text.include?("rss")
    end
    scraped_profile[:profile_quote] = html.css("div.profile-quote").text
    scraped_profile[:bio] = html.css("div.description-holder p").text
    scraped_profile  
  end

end

# name: html.css("h4.student-name").text
# location: html.css("p.student-location").text
# link: html.css("a").attribute("href").value