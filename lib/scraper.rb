require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".student-card").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_profile = "./fixtures/student-site/" + card.css("a").attribute("href").value
      students << {name: student_name, location: student_location, profile_url: student_profile}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {
      profile_quote: profile_page.css(".profile-quote").text,
      bio: profile_page.css(".bio-content .description-holder p").text
    }
    profile_page.css(".social-icon-container a").each do |social|
      image = social.css("img").attribute("src").text
      url = social.attribute("href").text
      case image
      when "../assets/img/twitter-icon.png"
        student[:twitter] = url
      when "../assets/img/linkedin-icon.png"
        student[:linkedin] = url
      when "../assets/img/github-icon.png"
        student[:github] = url
      when "../assets/img/rss-icon.png"
        student[:blog] = url
      end
    end
    student
  end

end
