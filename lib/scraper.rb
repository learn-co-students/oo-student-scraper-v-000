require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card a")
    return_students = []
    students.each do |student|
      return_students << {
              name: student.css(".student-name").text,
              location: student.css(".student-location").text,
              profile_url: "#{student.attr('href')}"
            }
    end
    return_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    vitals = doc.css(".vitals-container")
    bio_details = doc.css("div.bio-block")
    social_container = vitals.css(".social-icon-container")
    social_container.children.css("a").each do |link|
      url = link.attribute('href').value
      if url.include?("linkedin")
        student[:linkedin] = url
      elsif url.include?("github")
        student[:github] = url
      elsif url.include?("twitter")
        student[:twitter] = url
      else
        student[:blog] = url
      end
    end

    student[:profile_quote] = vitals.css(".vitals-text-container .profile-quote").text
    student[:bio] = bio_details.css("p").text

    return student
  end

end

profile_url = "./fixtures/student-site/students/david-kim.html"
scraped_student = Scraper.scrape_profile_page(profile_url)
