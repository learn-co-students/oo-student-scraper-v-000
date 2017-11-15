require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    container = Nokogiri::HTML(open(index_url))

    index_page = []

    container.css("div.roster-cards-container").each do |student|
      student.css(" .student-card a").each do |card|
        unit = {
          :name => card.css(" .student-name").text,
          :location => card.css(" .student-location").text,
          :profile_url => "#{card.attr('href')}"
        }
        index_page << unit
      end
    end
    index_page
  end

  def self.scrape_profile_page(profile_url)
    container = Nokogiri::HTML(open(profile_url))

    profile_page = {}

    links = container.css(".social-icon-container a").collect { |a_tags| a_tags.attr('href') }

      links.each do |link|
        link
        if link.include?("linkedin")
          profile_page[:linkedin] = link
        elsif link.include?("github")
          profile_page[:github] = link
        elsif link.include?("twitter")
          profile_page[:twitter] = link
        else
        profile_page[:blog] = link
        end
      end

    profile_page[:profile_quote] = container.css("div.profile-quote").text
    profile_page[:bio] = container.css("div.description-holder p").text

    profile_page
    #binding.pry
  end

end
