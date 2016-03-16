require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.search("div.student-card")

    students.map do |student|
      student_hash = {
        :name => student.search("h4").text,
        :location => student.search("p").text,
        :profile_url => "http://127.0.0.1:4000/#{student.search("a").first.attr("href")}"
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css(".social-icon-container").children.css("a").collect {|link| link.attribute('href').value}

    student = {
      :bio => profile.css(".description-holder p").text,
      :profile_quote => profile.css("div.profile-quote").text
    }

    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      else
        student[:blog] = link
      end
    end

    student
  end
end
