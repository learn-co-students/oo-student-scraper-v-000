require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_arr = []

    all_students = doc.css("div.roster-cards-container")
    students = all_students.css("div.student-card")
    students.each do |student|
      profile= {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p").text,
        :profile_url => index_url + student.css("a").attribute("href").value
      }
      student_arr<<profile
    end
    student_arr
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