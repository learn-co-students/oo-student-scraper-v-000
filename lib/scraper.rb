require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    all_students = []
    doc.css(".student-card").each do |person|
      student = {}
      student[:name] = person.css("h4").text
      student[:location] = person.css("p").text
      student[:profile_url] = "./fixtures/student-site/#{person.css("a").attr("href").text}"
      all_students << student
    end
    all_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}
    links = doc.css(".social-icon-container a")
    links.each do |link|
      url = link.attr("href")
      if url.to_s.include?("twitter")
        student_info[:twitter] = url
      elsif url.to_s.include?("linkedin")
        student_info[:linkedin] = url
      elsif url.to_s.include?("github")
        student_info[:github] = url
      else
        student_info[:blog] = url
      end
    end
    student_info[:profile_quote] = doc.css(".profile-quote").text
    student_info[:bio] = doc.css("p").text
    student_info
  end

end

