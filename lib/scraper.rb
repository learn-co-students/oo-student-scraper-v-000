require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes = []

    file = File.read(index_url)
    doc = Nokogiri::HTML(file)

    doc.css('.student-card').each do |student_card|
      student_hash = {}

      student_hash[:name] = student_card.css('.student-name').text
      student_hash[:location] = student_card.css('.student-location').text

      url_beginning = "./fixtures/student-site/"

      student_specific_url = student_card.css('a')[0]['href']
     # binding.pry

      student_hash[:profile_url] = url_beginning + student_specific_url

      array_of_student_hashes << student_hash
    end
    array_of_student_hashes
  end

  def self.scrape_profile_page(profile_url)
    file = open(profile_url)
    doc = Nokogiri::HTML(file)

    student_hash = {}

    all_links = doc.css('.social-icon-container a').map { |link| link['href'] }

    all_links.each do |link|
      if link.include?('twitter')
        student_hash[:twitter] = link
      elsif link.include?('linkedin')
        student_hash[:linkedin] = link
      elsif link.include?('github')
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end       
    end

    student_hash[:profile_quote] = doc.css('.profile-quote').text
    student_hash[:bio] = doc.css('.bio-content .description-holder p').text

    #binding.pry

    student_hash
  end

end

