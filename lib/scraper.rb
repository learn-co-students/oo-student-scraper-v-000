require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_hashes = []

    page = Nokogiri::HTML(open(index_url))

    students = page.css("div.student-card")

    students.each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hashes << student_hash
    end

    student_hashes
  end

  def self.scrape_profile_page(profile_url)
    student = {}

    page = Nokogiri::HTML(open(profile_url))

    student[:profile_quote] = page.css("div.profile-quote").text
    student[:bio] = page.css("div.bio-content div.description-holder p").text

    page.css("div.social-icon-container a").each do |link|
      link_href = link.attribute("href").value

      if link_href.include?("twitter")
        student[:twitter] = link_href
      elsif link_href.include?("linkedin")
        student[:linkedin] = link_href
      elsif link_href.include?("github")
        student[:github] = link_href
      # elsif link_href.include?("youtube")
        # student[:youtube] = link_href
      else
        student[:blog] = link_href
      end

    end

    student
  end

end
