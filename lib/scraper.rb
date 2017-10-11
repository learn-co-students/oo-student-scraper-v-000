require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)

    students = Nokogiri::HTML(html)
    student_index_array = []

    students.css("div.student-card").each do |student|
      student_index_array << {name: student.css(" a div.card-text-container h4").text, location: student.css(" a div.card-text-container p").text, profile_url: student.css("a").attribute("href").value}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    name = profile_url.split("/").pop.gsub(".html", "").split("-").first.to_sym

    student = Nokogiri::HTML(html)
    student_hash = {}

    student.css("div.social-icon-container a").each do |icon|
      icon_name = icon.attribute("href").value.split(/:\/\//).pop.split(".com").shift.gsub("www.", "")
      if icon_name == "twitter" || icon_name == "linkedin" || icon_name == "github" || icon_name == "youtube"
        student_hash[icon_name.to_sym] = icon.attribute("href").value
      else
        student_hash[:blog] = icon.attribute("href").value
      end
    end

    student_hash[:profile_quote] = student.css("div.profile-quote").text
    student_hash[:bio] = student.css("div.bio-content.content-holder div.description-holder p").text
  #  student_hash = {twitter: icon_array[0], linkedin: icon_array[1], github: icon_array[2], blog: icon_array[3]}
  student_hash

  end

end
