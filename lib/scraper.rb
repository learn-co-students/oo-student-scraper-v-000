require 'open-uri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      student_profile = "#{student.attr('href')}"
      student_location = student.css('.student-location').text
      student_name = student.css('.student-name').text
      cards << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
      cards
    end


  def self.scrape_profile_page(profile_url)
    docs = Nokogiri::HTML(open(profile_url))
    profiles = {}
    links = docs.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
  links.each do |link|
    if link.include?("linkedin")
      profiles[:linkedin] = link
    elsif link.include?("github")
      profiles[:github] = link
    elsif link.include?("twitter")
      profiles[:twitter] = link
    else
      profiles[:blog] = link
    end
  end
  profiles[:profile_quote] = docs.css(".profile-quote").text if docs.css(".profile-quote")
  profiles[:bio] = docs.css("div.bio-content.content-holder div.description-holder p").text if docs.css("div.bio-content.content-holder div.description-holder p")
      profiles
    end

end
