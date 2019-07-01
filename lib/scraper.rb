require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".roster-cards-container .student-card")
    students_array = Array.new

    students.each do |stud|
      student = Hash.new
      student[:name] = stud.css("h4").text
      student[:location] = stud.css("p").text
      student[:profile_url] = stud.css("a")[0]["href"]
      students_array << student
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_xml = doc.css(".main-wrapper")
    social_media = student_xml.css(".social-icon-container a")

    student = Hash.new
    social_media.each { |social|
      # binding.pry
      href = social["href"]
      if href.include?("twitter")
        student[:twitter] = href
      elsif href.include?("linkedin")
        student[:linkedin] = href
      elsif href.include?("github")
        student[:github] = href
      elsif href.include?("youtube")
        puts "we do not accept youtube"
      else
        student[:blog] = href
      end
      href = ""
    }

    profile = student_xml.css(".vitals-text-container")
    details = student_xml.css(".details-container")
    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = details.css("p").text
    # binding.pry
    student
  end

end
