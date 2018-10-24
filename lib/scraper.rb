require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #binding.pry
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("a")
    student_array = []
    #binding.pry
    students.each do |student|
      student_array << {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student["href"]}
    end
    student_array.shift
    student_array
  end

  def self.scrape_profile_page(profile_url)
    #binding.pry
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    social = doc.css("div.social-icon-container a")
    profile = {}
    links = social.collect {|link| link["href"]}
    
    links.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else 
        profile[:blog] = link
      end 
    end 
    
    profile[:profile_quote] = doc.css("div.vitals-text-container div").text
    profile[:bio] = doc.css("div.description-holder p").text
    
    profile
  end

end

