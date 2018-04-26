require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    students = doc.css('div.roster-cards-container').css('.student-card a')
    students.each do |card|
      student_name = card.css('.card-text-container h4').text
      student_location = card.css('.card-text-container p').text
      student_pofile = card.attr('href')
      scraped_students << {:name => student_name, :location => student_location, :profile_url => student_pofile}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_info = Nokogiri::HTML(html)
    student_hash = {}

    social = student_info.css('.social-icon-container a').map {|s| s.attr('href')}
    social.each do |s|
      if s.include?("linkedin")
        student_hash[:linkedin] = s
      elsif s.include?("github")
        student_hash[:github] = s
      elsif s.include?("twitter")
          student_hash[:twitter] = s
      else
          student_hash[:blog] = s
      end
    end

    profile = student_info.css('.profile-quote').text
    student_hash[:profile_quote] = profile

    bio = student_info.css('.description-holder p' ).text
    student_hash[:bio] = bio

    student_hash
  end

end
