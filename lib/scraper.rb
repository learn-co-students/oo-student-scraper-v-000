require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url = 'fixtures/student-site/index.html')
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []

    index_page.css('div.student-card a').each do |student|
      student_hash = { name: student.css('h4.student-name').text, location: student.css('p.student-location').text, profile_url: './fixtures/student-site/' + student.attribute('href').value }
      students.push << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student_profile = {}
    social_links = profile_page.css('div.social-icon-container a')
    social_links.collect do |link|
      if link.children[0].attribute('src').value == '../assets/img/twitter-icon.png'
        student_profile[:twitter] = link.attribute('href').value
      elsif link.children[0].attribute('src').value == '../assets/img/linkedin-icon.png'
        student_profile[:linkedin] = link.attribute('href').value
      elsif link.children[0].attribute('src').value == '../assets/img/github-icon.png'
        student_profile[:github] = link.attribute('href').value
      elsif link.children[0].attribute('src').value == '../assets/img/rss-icon.png'
        student_profile[:blog] = link.attribute('href').value
      end
    end
    student_profile[:profile_quote] = profile_page.css('div.profile-quote').text
    student_profile[:bio] = profile_page.css('div.description-holder p').text
    student_profile
  end
end
