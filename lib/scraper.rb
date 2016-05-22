require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    complete_page = Nokogiri::HTML(open(index_url))
    student_array = []
    complete_page.css("div.roster-cards-container").each do |roster_card|
      roster_card.css(".student-card a").each do |ind_student|
        student_profile_url = "http://127.0.0.1:4000/#{ind_student.attr('href')}"
        student_loc = ind_student.css('.student-location').text
        student_n = ind_student.css('.student-name').text
        student_array << {name: student_n, location: student_loc, profile_url: student_profile_url}
      end
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    complete_page = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    social_links = complete_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    social_links.each do |social_link|
      if social_link.include?("twitter")
        student_hash[:twitter] = social_link
      elsif social_link.include?("linkedin")
        student_hash[:linkedin] = social_link
      elsif social_link.include?("github")
        student_hash[:github] = social_link
      else
        student_hash[:blog] = social_link
      end
    end
    student_hash[:profile_quote] = complete_page.css(".profile-quote").text if complete_page.css(".profile-quote")
    student_hash[:bio] = complete_page.css("div.bio-content.content-holder div.description-holder p").text if complete_page.css("div.bio-content.content-holder div.description-holder p")
    student_hash    
  end

end

