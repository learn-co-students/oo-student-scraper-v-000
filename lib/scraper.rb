require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url))
      students = []

      doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    links = doc.css("div.social-icon-container a").collect {|icon| icon.attribute('href').value}
      links.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("github")
          student[:github] = link

        else
          student[:blog] = link
        end
      end

      student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    student

  end

end
