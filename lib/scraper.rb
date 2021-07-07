require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')

    student_site = Nokogiri::HTML(html)
    student_cards = student_site.css(".student-card")

    scraped_students = []
    student_cards.each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
        }
    end
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    profile_site = Nokogiri::HTML(profile_html)
    details = {}

    profile_site.css("div.social-icon-container a").each do |social_link|
      #linkedin, github, blog, twitter profileQuite, bio
      link = social_link.attribute("href").value

      case
      when link.include?("twitter")
          details[:twitter] = link
      when link.include?("linkedin")
          details[:linkedin] = link
      when link.include?("github")
          details[:github] = link
      when link.include?(".com")
          details[:blog] = link
      end
      details[:profile_quote] = profile_site.css(".profile-quote").text
      details[:bio] = profile_site.css("div.description-holder p").text
    end
    details
  end
end
