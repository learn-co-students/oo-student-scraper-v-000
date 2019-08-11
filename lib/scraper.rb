require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_doc = Nokogiri::HTML(open(index_url))
    students = []
    index_doc.css("div.student-card").each do |student|
      info = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      students << info
    end
  students
  end

  def self.scrape_profile_page(profile_url)
    students_page = {}

    profile_page = Nokogiri::HTML(open(profile_url))

    students_page[:profile_quote] = profile_page.css('.profile-quote').text
    students_page[:bio] = profile_page.css('.bio-content p').text

    profile_links = profile_page.css(".social-icon-container a")
    profile_links.each do |link|
      url = link.attr('href')

      if url.include?("linkedin")
        students_page[:linkedin] = url
      elsif url.include?("github")
        students_page[:github] = url
      elsif url.include?("twitter")
        students_page[:twitter] = url
      else
        students_page[:blog] = url
      end
    end
     students_page
  end

end
