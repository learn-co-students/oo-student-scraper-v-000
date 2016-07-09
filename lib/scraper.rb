require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # http://159.203.117.55:3718/fixtures/student-site/
    # main css = div.roster-cards-container
    # :name => #student-name
    # :location => #student-location
    # :profile_url => div#student-card a

    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile_url = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_slug)
    # profile-quote
    # social-icon-container

    student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
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
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")
    student
  end
end
