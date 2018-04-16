require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    scraped_students = []

    html = Nokogiri::HTML(open(index_url))
    get_students = html.css(".student-card")

    get_students.each_with_index do |student, index|
      scraped_students[index] = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end

    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = Nokogiri::HTML(open(profile_url))
    social_links = html.css(".social-icon-container a")

    social_links.each do |link|

      link_value = link.attribute("href").value
      key = link.css("img").attribute("src").value.split("/")[-1].split("-")[0]

      if key == "rss"
        scraped_student[:blog] = link_value
      else
        scraped_student[key.to_sym] = link_value
      end
    end

    scraped_student[:profile_quote] = html.css(".vitals-text-container .profile-quote").text
    scraped_student[:bio] = html.css(".bio-content .description-holder").text.strip
    scraped_student
  end

end
