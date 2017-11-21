require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    Nokogiri::HTML(open(index_url)).css(".student-card").each do |student|
      new_student = {}
      new_student[:name] = student.css(".student-name").text
      new_student[:location] = student.css(".student-location").text
      new_student[:profile_url] = student.css("a").attribute("href").value
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    doc = Nokogiri::HTML(open(profile_url)).css(".main-wrapper")

    doc.css(".social-icon-container a").each do |link|
      link = link.attribute("href").value
      link_type = link.scan(/\b+\w{1,}(?=\.)/).last
      if link_type =~ /twitter|linkedin|github/
        profile[link_type.to_sym] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end

end
