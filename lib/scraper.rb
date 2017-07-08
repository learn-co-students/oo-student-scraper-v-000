require 'open-uri'
require 'pry'
require_relative '../config'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    nested_html = Nokogiri::HTML(html)

    student_cards = nested_html.css('.student-card')
    # binding.pry
    scraped_array = []

    student_cards.each do |student_card|
      scraped_array << {
                        name: student_card.css('a .card-text-container .student-name').text,
                        location: student_card.css('a .card-text-container .student-location').text,
                        profile_url: student_card.css('a').attr('href').value
                        }
            # binding.pry
    end
# binding.pry
    scraped_array

  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    nested_html = Nokogiri::HTML(profile_html)

    scraped_hash = {}

      # for social media links
        # grab links
        # place in hash with appropriate keys
          # method 1: use regex to identify the root uri
    social_media = nested_html.css('.social-icon-container a')
    social_media.each do |anchor|

      link = anchor.attr('href')
      uri = link.gsub(/.com.*/, "")
      root_uri = uri.gsub(/.*\/{2}w*\.*/, "")
      case root_uri

      when 'twitter', 'github', 'linkedin'
        scraped_hash[root_uri.to_sym] = link
      else
        scraped_hash[:blog] = link
      end

    end

    scraped_hash[:profile_quote] = nested_html.css('.profile-quote').text
    scraped_hash[:bio] = nested_html.css('.bio-content .description-holder p').text
# binding.pry
    scraped_hash
  end

end
