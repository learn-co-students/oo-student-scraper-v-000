require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_students = Nokogiri::HTML(html)

    students = []
    learn_students.css("div.roster-cards-container div.student-card").each do |student|
      student_name = student.css("div.card-text-container h4.student-name").text
      student_location = student.css("div.card-text-container p.student-location").text
      student_profile_url = student.css("a").attribute("href").value
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    students
    # name: student.css("div.card-text-container h4.student-name").text
    # location: student.css("div.card-text-container p.student-location").text
    # url: student.css("a").attribute("href").value
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    learn_students_profiles = Nokogiri::HTML(html)
    student = {}


    url_links = learn_students_profiles.css("div.social-icon-container a").collect do |a|
                  a.attribute("href").value
                end
  #=> Gives an array of the url links

  url_links.each do |link|
    if link.include?("twitter.com")
      student[:twitter] = link
    elsif link.include?("linkedin.com")
      student[:linkedin] = link
    elsif link.include?("github.com")
      student[:github] = link
    else
      student[:blog] = link
    end
  end

    student[:bio] = learn_students_profiles.css("div.description-holder p").text
    student[:profile_quote] = learn_students_profiles.css("div.profile-quote").text

    # bio: learn_students_profiles.css("div.description-holder p").text
    # profiles.css("div.social-icon-container a").attribute("href").value
    # quote: learn_students_profiles.css("div.profile-quote").text

    student
  end
end
