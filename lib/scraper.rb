require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    get_page = Nokogiri::HTML(open(index_url))

    scraped_students = []
    get_page.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => index_url + student.at("a").attributes["href"].value
      }
    end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    get_page = Nokogiri::HTML(open(profile_url))

    student_profile = {
      :profile_quote => get_page.css(".profile-quote").text,
      :bio => get_page.css("p").text
    }

    get_page.css("div.social-icon-container a").each do |social|
      case social.at("img").attributes["src"].value
      when "../assets/img/twitter-icon.png"
        student_profile[:twitter] = social.attributes["href"].value
      when "../assets/img/linkedin-icon.png"
        student_profile[:linkedin] = social.attributes["href"].value
      when "../assets/img/github-icon.png"
        student_profile[:github] = social.attributes["href"].value
      when "../assets/img/rss-icon.png"
        student_profile[:blog] = social.attributes["href"].value
      end
    end
    student_profile
  end
end
