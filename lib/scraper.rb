require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    website = Nokogiri::HTML(html)

    students = []
    website.css("div.student-card").each do |student|
      student_info = Hash.new
      student_info[:name] = student.css("h4.student-name").text
      student_info[:location] = student.css("p.student-location").text
      student_info[:profile_url] = student.css("a").attribute("href").value

      students << student_info

      #LOCATION: student.css("p.student-location").text
      #NAME: student.css("h4.student-name").text
      #URL: student.css("a").attribute("href").value
      #QUESTION: Does the profile_url address the rest of the path?  For example, is the profile_url incomplete without ./fixtures/student-site + profile_url ?
    end

    students
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    information = {}

    social_icons = profile.css("div.social-icon-container a")

    social_icons.each do |link|
      href = link.attribute("href").value
      # binding.pry
      if href.include?("twitter.com")
        information[:twitter] = href
      elsif href.include?("linkedin.com")
        information[:linkedin] = href
      elsif href.include?("github.com")
        information[:github] = href
      else
        information[:blog] = href
      end

      information[:bio] = profile.css("div.description-holder p").text
      information[:profile_quote] = profile.css("div.profile-quote").text

    end

    information
  end

end
