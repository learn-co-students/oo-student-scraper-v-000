require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    main_page = Nokogiri::HTML(open(index_url))
    students = []
    main_page.css("div.roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    studentss
  end



  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile.css(".social-icon-container").children.css('a').map { |e| e.attribute('href').value }
    links.each do |link|
      if link.include?('linkedin')
        student[:linkedin] = link
      elsif link.include?('github')
        student[:github] = link
      elsif link.include?('twitter')
        student[:twitter] = link
      else
        student[:blog] = link
      end

    end
  end

end


profile_url = "./fixtures/student-site/students/joe-burgess.html"
scraped_student = Scraper.scrape_profile_page(profile_url)
