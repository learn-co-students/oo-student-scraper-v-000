require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |person|
        profile = "./fixtures/student-site/#{person.attr('href')}"
        name = person.css('.student-name').text
        location = person.css('.student-location').text

        students << {name: name, location: location, profile_url: profile}
      end
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}

    social_links = doc.css(".social-icon-container").children.css("a").collect {|links| links.attribute('href').value}
    social_links.each do |link|
      if link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    if doc.css(".profile_quote")
      student[:profile_quote] = doc.css(".profile-quote").text
    end
    if doc.css("div.bio-content.content-holder div.description-holder p")
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    end

    student

  end

end

