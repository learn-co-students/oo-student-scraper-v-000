require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")

    students.each do |student|
      name = student.css('.student-name').text
      location = student.css('.student-location').text
      profile = "http://127.0.0.1:4000/#{student.css('a')[0]['href']}"
      student_list << {name: name, location: location, profile_url: profile}
    end
    
    student_list
  end

  def self.scrape_profile_page(profile_url)
    profile_url.downcase!
    student_info = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_info[:profile_quote] = doc.css('.profile-quote').text
    student_info[:bio] = doc.css('div.bio-content p').text

    doc.css('div.social-icon-container a').each do |link|
      student_info[:twitter] = link["href"] if link["href"].match(/twitter/)
      student_info[:github] = link["href"] if link["href"].match(/github/)
      student_info[:linkedin] = link["href"] if link["href"].match(/linkedin/)
      if link.children[0].attributes.any?
        student_info[:blog] = link["href"] if link.children[0].attributes["src"].value.match(/rss/)
      end
      #student_info[:blog] = link["href"] if link.children[0].attributes["src"].value.match(/rss/)
    end

    student_info
  end

end

