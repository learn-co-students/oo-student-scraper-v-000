require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def initialize
  end

  def self.scrape_index_page(index_url)
   students = Array.new
   doc = Nokogiri::HTML(open(index_url))
   doc.css('.student-card').each do |student|
     new_student = Hash.new
     profile_path = student.children[1].attribute_nodes[0].value
     new_student[:name] = student.children.css('.student-name').text
     new_student[:location] = student.children.css('.student-location').text
     new_student[:profile_url] = "http://127.0.0.1:4000/#{profile_path}".downcase
     students << new_student
   end
   students
  end

  def self.scrape_profile_page(profile_url)
    student = Hash.new
    student_page = Nokogiri::HTML(open(profile_url))
    links = student_page.css('div.social-icon-container a').map { |link| link['href'] }
    student_name = student_page.css('.profile-name').text.split(' ').last.downcase
    student[:twitter] = links.detect { |link| link =~ /\btwitter\b/ }
    student[:linkedin] = links.detect { |link| link =~ /\blinkedin\b/ }
    student[:github] = links.detect { |link| link =~ /\bgithub\b/ }
    student[:blog] = links.last
    student[:profile_quote] = student_page.css('.profile-quote').text
    student[:bio] = student_page.css('div.description-holder p').text.gsub('\n','').split(' ').compact.join(' ')
    student
  end

end

