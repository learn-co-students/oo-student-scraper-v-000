require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    page.css(".student-card").each do |student_card|
      student = {}
      short_url = student_card.css("a")[0]["href"]
      student[:name] = student_card.css("a h4").text
      student[:location] = student_card.css("a p").text
      student[:profile_url] = "./fixtures/student-site/#{short_url}"
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_attributes = {}
    page = Nokogiri::HTML(open(profile_url))
    social = page.css(".social-icon-container a")
    social.each do |link|
      social_link = link['href']
      case
      when social_link.include?("twitter")
        student_attributes[:twitter] = social_link
      when social_link.include?("linkedin")
        student_attributes[:linkedin] = social_link
      when social_link.include?("github")
        student_attributes[:github] = social_link
      # when social_link.include?("youtube")
      #   student_attributes[:youtube] = social_link
      else
        student_attributes[:blog] = social_link
      end
    end

    student_attributes[:profile_quote] = page.css(".vitals-text-container div").text
    student_attributes[:bio] = page.css(".bio-block .description-holder p").text

    student_attributes
  end

end
