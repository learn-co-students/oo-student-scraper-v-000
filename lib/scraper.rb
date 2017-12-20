require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").each do |card|
      name_variable = card.css('h4').text
      location_variable = card.css("p").text

      profile_url_variable = card.css("a").attr('href').value

      array << {name: name_variable, location: location_variable, profile_url: profile_url_variable}
    end

    array
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text

    doc.css("div.social-icon-container a").each do |link|
      if link.attr('href').include?("twitter")
        student[:twitter] = link.attr('href')
      elsif link.attr('href').include?("linkedin")
        student[:linkedin] = link.attr('href')
      elsif link.attr('href').include?("github")
        student[:github] = link.attr('href')
      else
        student[:blog] = link.attr('href')
      end
    end
    student

  end

end
