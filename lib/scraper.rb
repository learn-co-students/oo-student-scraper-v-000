require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    students = []

    doc.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/"+student.css("a").attribute("href")
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    
    student_profile = {}

    profile.css("div.social-icon-container a").each do |student|
      prof = student.attribute("href").value
      student_profile[:twitter] = prof if prof.include?("twitter")
      student_profile[:facebook] = prof if prof.include?("facebook")
      student_profile[:github] = prof if prof.include?("github")
      student_profile[:linkedin] = prof if prof.include?("linkedin")
      student_profile[:blog] = prof if student.css("img").attribute("src").text.include?("rss")
      student_profile[:profile_quote] = profile.css("div.profile-quote").text
      student_profile[:bio] = profile.css("div.description-holder p").text
    end
    student_profile
    #binding.pry
  end



end #ends class Scraper

