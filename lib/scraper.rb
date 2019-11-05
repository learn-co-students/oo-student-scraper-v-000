require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []

    page.css(".student-card").each_with_index do |student_card, i|
      students << {
        :name => student_card.css(".student-name").text,
        :location => student_card.css(".student-location").text,
        :profile_url => student_card.css("a")[0]["href"]
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    page.css(".social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        student_profile[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        student_profile[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        student_profile[:github] = link["href"]
      elsif
        student_profile[:blog] = link["href"]
      end
    end

    student_profile[:profile_quote] = page.css(".profile-quote").text
    student_profile[:bio] = page.css(".bio-content .description-holder").text.strip
    student_profile
  end

end
