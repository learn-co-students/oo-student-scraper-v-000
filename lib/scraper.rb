require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_info_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".student-card").each do |student|
      info_hash = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => index_url + student.css("a").attribute("href").value
      }
      students_info_array << info_hash
    end
    students_info_array
  end
  # binding.pry
  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile_pages = {
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text,
    }
    student_info = doc.css(".social-icon-container a").map do |link|
      link.attribute("href").value
    end
    student_info.each do |link|
        if link.include?("twitter")
          profile_pages[:twitter] = link
        elsif link.include?("linkedin")
          profile_pages[:linkedin] = link
        elsif link.include?("github")
          profile_pages[:github] = link
        else
          profile_pages[:blog] = link
        end
      end
      profile_pages
    end
  # end

end

