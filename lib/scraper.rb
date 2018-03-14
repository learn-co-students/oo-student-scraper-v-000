require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_array = doc.css(".roster-cards-container .student-card")
    final_students = []
    students_array.each do |el|
      student_hash = Hash.new(0)
      student_hash[:name] = el.css("h4").text
      student_hash[:location] = el.css("p").text
      student_hash[:profile_url] = el.css("a").attr('href').text
      final_students << student_hash
    end
    final_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_card = doc.css(".social-icon-container").css("a")
    array = []
    links = student_card.each { |el| array << el.attr('href') }
    profile_quote = doc.css(".vitals-text-container div").text
    bio = doc.css("p").text
    array += [profile_quote, bio]
    hash = Hash.new(0)
    array.each { |el| hash[:twitter] = el if el.include?("twitter") }
    array.each { |el| hash[:linkedin] = el if el.include?("linkedin") }
    array.each { |el| hash[:github] = el if el.include?("github") }
    array.each { |el| hash[:blog] = el if el == array[-3] && !el.include?("twitter") && !el.include?("linkedin") && !el.include?("github") }
    hash[:profile_quote] = array[-2]
    hash[:bio] = array[-1]
    hash

  end

end
