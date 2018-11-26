require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    info = Nokogiri::HTML(open(index_url))

    students_array = []

    info.css(".student-card").each do |student|
      students_array << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    info = Nokogiri::HTML(open(profile_url))

    student = {}

    links = info.css(".social-icon-container a").collect {|link| link.attribute("href").value}

    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end

    student[:profile_quote] = info.css(".profile-quote").text
    student[:bio] = info.css(".description-holder p").text

    student
  end

end
