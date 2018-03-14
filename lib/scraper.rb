require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css('.student-card')
    student_index_array = []

    student_cards.each do |student|
      name = student.css('h4.student-name').text
      location = student.css('p.student-location').text
      profile_url = student.css('a').attr('href').value

      student_hash = {:name => name, :location => location, :profile_url => profile_url}
      student_index_array << student_hash
    end

    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css(".social-icon-container a")
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".description-holder p").text
    student_hash = {}
    social_links.each do |social_link|
      link = social_link.attr('href')
      case
      when link.include?("twitter")
        student_hash[:twitter] = link
      when link.include?("linkedin")
        student_hash[:linkedin] = link
      when link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = profile_quote
    student_hash[:bio] = bio
    student_hash
  end

end
