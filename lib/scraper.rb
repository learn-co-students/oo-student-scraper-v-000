require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    infos = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.roster-cards-container").each do |c|
      c.css('.student-card a').each do |student|
        profile = "#{student.attr('href')}"
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        infos << {name: name, profile_url: profile, location: location}
      end
    end
    infos
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container").children.css("a").map { |w| w.attribute('href').value}
    links.each do |url|
      if url.include?("linkedin")
        student[:linkedin] = url
      elsif url.include?("github")
        student[:github] = url
      elsif url.include?("twitter")
        student[:twitter] = url
      else
        student[:blog] = url
      end
    end

     student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
     student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    student
  end

end
