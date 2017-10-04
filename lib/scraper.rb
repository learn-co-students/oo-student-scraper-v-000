require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {
          name: student.css('.student-name').text,
          location: student.css('.student-location').text,
          profile_url: "#{student.attr('href')}"
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile_page.css(".social-icon-container").children.css("a").map { |elem| elem.attribute('href').value}
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
    student[:profile_quote] = profile_page.css(".vitals-text-container .profile-quote").text
    student[:bio] = profile_page.css(".description-holder p").text
    student
  end
end
