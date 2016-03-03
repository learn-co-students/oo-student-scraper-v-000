require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
      html = Nokogiri::HTML(open(index_url))

      students = []

      html.css('div.student-card').each do |student_card|
          student_name = student_card.css('a div.card-text-container h4.student-name').text
          student_location = student_card.css('a div.card-text-container p.student-location').text
          student_url ="http://127.0.0.1:4000/#{student_card.css('a').attribute('href').value}"

          students << {name: student_name, location: student_location, profile_url: student_url}
      end
      students
  end

  def self.scrape_profile_page(profile_url)
      profile = Nokogiri::HTML(open(profile_url))

      student_hash = {}

      student_links = profile.css('.social-icon-container').children.css('a').map do |link|
          link.attribute('href').value
        end
      student_links.each do |link|
          if link.include?("linkedin")
            student_hash[:linkedin] = link
          elsif link.include?("github")
            student_hash[:github] = link
          elsif link.include?("twitter")
            student_hash[:twitter] = link
          else
            student_hash[:blog] = link
          end
      end

        student_hash[:profile_quote] = profile.css('.profile-quote').text if profile.css('.profile-quote')

        student_hash[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

        student_hash
  end

end
