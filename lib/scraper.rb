require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_doc = Nokogiri::HTML(open(index_url))
    students = []
    index_doc.css("div.roster-cards-container").each do |student_card|
      student_card = index_doc.css(".student-card a").map do |student|
        students << {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => student.attr('href')
        }
      end
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    student_page = {}
    profile_page = Nokogiri::HTML(open(profile_url))

    student_page[:profile_quote] = profile_page.css('.profile-quote').text
    student_page[:bio] = profile_page.css('.bio-content p').text

    profile_links = profile_page.css(".social-icon-container a")
    profile_links.each do |link|
      url = link.attr('href')

      if url.include?("linkedin")
        student_page[:linkedin] = url
      elsif url.include?("github")
        student_page[:github] = url
      elsif url.include?("twitter")
        student_page[:twitter] = url
      else
        student_page[:blog] = url
      end
    end
     student_page
  end
end
