require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students = Nokogiri::HTML(html)
    student_cards = students.css("div.student-card")
    all_students = Array.new

    student_cards.each do |student|
      student_hash = Hash.new
      student_hash[:name] = student.css("a .card-text-container .student-name").text
      student_hash[:location] = student.css("a .card-text-container .student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      all_students << student_hash
    end
    return all_students
  end

  def self.scrape_profile_page(profile_url)
    page = File.read(profile_url)
    profile = Nokogiri::HTML(page)
    student_vitals = profile.css(".vitals-container")
    student_details = profile.css(".details-container")
    student_profile = profile.css(".social-icon-container a")
    # profile.css(".social-icon-container a[href*=\"twitter\"]").attribute("href").value

    student = Hash.new

    student_profile.each do |profile|
      social = profile.attributes["href"].value

      if social.include?("twitter")
        student[:twitter] = social
      elsif social.include?("linkedin")
        student[:linkedin] = social
      elsif social.include?("github")
        student[:github] = social
      else
        student[:blog] = social
      end
    end

    student[:profile_quote] = student_vitals.css(".vitals-text-container .profile-quote").text
    student[:bio] = student_details.css(".description-holder p").text

    return student
  end
end
