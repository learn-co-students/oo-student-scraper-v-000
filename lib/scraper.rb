require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    Nokogiri::HTML(open(index_url)).css(".student-card a").each do |cards|
      cards.each do |student|
        student = {}
        student[:name] = cards.search("h4.student-name").text
        student[:location] = cards.search("p.student-location").text
        student[:profile_url] = cards["href"]
        students_array << student
      end
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    profile_links = html.search(".social-icon-container a").collect { |link| link['href'] }
    profile_links.each do |link|
      if link.include? "twitter"
        student_profile[:twitter] = link
      elsif link.include? "linkedin"
        student_profile[:linkedin] = link
      elsif link.include? "github"
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = html.search(".profile-quote").text
    student_profile[:bio] = html.search(".description-holder p").text
    student_profile
  end
end
