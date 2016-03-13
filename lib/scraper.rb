require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url, :students

  def self.scrape_index_page(index_url)

    students_array = []

    index = Nokogiri::HTML(open(index_url))

    index.css(".student-card").each do |student|
      student_hash = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => index_url + student.css("a").attribute("href").value
      }
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    student_pages = {
      :profile_quote => doc.css("div.profile-quote").text,
      :bio => doc.css(".description-holder p").text
    }

    student_links = doc.css(".social-icon-container a").map do |icon|
      icon.attribute("href").value
    end

    student_links.each do |icon|
      if icon.include?("twitter")
        student_pages[:twitter] = icon
      elsif icon.include?("linkedin")
        student_pages[:linkedin] = icon
      elsif icon.include?("github")
        student_pages[:github] = icon
      else
        student_pages[:blog] = icon
      end
    end
    student_pages
  end

end
