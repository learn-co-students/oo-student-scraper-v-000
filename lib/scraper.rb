require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []

    page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)

    student_profile = {}

    links = page.css('div.social-icon-container a').collect{ |social_icon| social_icon['href'] }
    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = page.css('div.profile-quote').text
    student_profile[:bio] = page.css('div.bio-content.content-holder p').text
    student_profile
  end
end
