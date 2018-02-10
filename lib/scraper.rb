require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'


class Scraper
  #
  # html = File.read("./fixtures/student-site/index.html")
  # doc = Nokogiri::HTML(html)

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    @@students = []

    doc.css(".roster-cards-container .student-card").each do |student_card|
      student_card_hash = {}
      #student = Student.new(student_card_hash)
      student_name = student_card.css("h4").text
      student_card_hash[:name] = student_name
      student_location = student_card.css("p").text
      student_card_hash[:location] = student_location
      student_profile_url = student_card.css("a")[0]["href"]
      student_card_hash[:profile_url] = student_profile_url
      @@students << student_card_hash
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    individual_student_attributes_hash = {}

    list_of_links = doc.css(".vitals-container .social-icon-container a").collect {|thing| thing["href"]}

    profile_quote = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      individual_student_attributes_hash[:profile_quote] = profile_quote
    bio = doc.css(".details-container .description-holder p").text
      individual_student_attributes_hash[:bio] = bio

#binding.pry
    list-of-links.each do |link|
      if link.include?("linkedin")
        individual_student_attributes_hash[:linkedin] = link
      elsif link.include?("twitter")
        individual_student_attributes_hash[:twitter] = link
      elsif link.include?("github")
        individual_student_attributes_hash[:github] = link
      elsif link.include?("blog")
        individual_student_attributes_hash[:blog] = link
    end

    individual_student_attributes_hash

  end

end
