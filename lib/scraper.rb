require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # index_page.css("div.student-card a div.card-text-container h4.student-name").first.text
    # => "Ryan Johnson"
    # index_page.css("div.student-card a div.card-text-container p.student-location").first.text
    # => "New York, NY"
    # index_page.css("div.student-card a").first.attribute("href").value
    # => "students/ryan-johnson.html"
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []
    index_page.css("div.roster-cards-container").each do |student_card|
      student_card.css("div.student-card a").each do |student|
        student_name = student.css("div.card-text-container h4.student-name").text
        student_location = student.css("div.card-text-container p.student-location").text
        student_profile_link = "./fixtures/student-site/#{student['href']}"
      scraped_students << {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_attributes = {}
    links = profile_page.css("div.social-icon-container").css("a").collect {|link| link.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student_attributes[:linkedin] = link
      elsif link.include?("github")
        student_attributes[:github] = link
      elsif link.include?("twitter")
        student_attributes[:twitter] = link
      else
        student_attributes[:blog] = link
      end
    end
    student_attributes[:bio] = profile_page.css("div.bio-content div.description-holder p").text
    student_attributes[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text
    student_attributes
  end

end