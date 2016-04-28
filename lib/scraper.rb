require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('.roster-cards-container .student-card a')
    scraped_students = []

    students.each do |student|
      name = student.css('.student-name').text
      location = student.css('.student-location').text
      profile_url = "http://127.0.0.1:4000/#{student.attr('href')}"
      scraped_students << {:name => name, :location => location, :profile_url => profile_url}
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    urls = doc.css(".social-icon-container").children.css("a").map { |link| link.attribute('href').value}
    urls.each do |url|
      if url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("github")
        profile[:github] = url
      elsif url.include?("twitter")
        profile[:twitter] = url
      else
        profile[:blog] = url
      end
    end

    profile[:profile_quote] = doc.css('.profile-quote').text
    profile[:bio] = doc.css('.bio-content.content-holder p').text

    profile
  end

end

