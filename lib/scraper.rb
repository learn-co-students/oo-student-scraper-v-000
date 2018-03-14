require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("http://104.236.196.127:8006/fixtures/student-site/"))
    student_cards = doc.css(".student-card a")
    students = []
    student_cards.each do |student_card|
      students << { :name => student_card.css(".card-text-container .student-name").text,
                    :location => student_card.css(".card-text-container .student-location").text,
                    :profile_url => "./fixtures/student-site/#{student_card['href']}"
                  }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile = {
      :profile_quote=> profile_page.css(".profile-quote").text,
      :bio=> profile_page.css(".description-holder p").text
    }
    social_icons = profile_page.css(".social-icon-container a")
    social_icons.each do |social|
      if social['href'].include?('twitter')
        profile[:twitter] = social['href']
      elsif social['href'].include?('linkedin')
        profile[:linkedin] = social['href']
      elsif social['href'].include?('github')
        profile[:github] = social['href']
      elsif social.css("img").attr("src").value.include?("rss-icon.png")
        profile[:blog] = social['href']
      end
    end
    profile
  end

end
