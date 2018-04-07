require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css("div.roster-cards-container").each do |people|
      people.css(".student-card").each do |person|
      student = {}
      student[:name] = person.css("div h4.student-name").text
      student[:location] = person.css("p.student-location").text
      student[:profile_url] = person.css("a").attribute("href").value
      student_array << student
        end
      end
      student_array
    end


  def self.scrape_profile_page(profile_url)
    student_links = {}
    doc = Nokogiri::HTML(open(profile_url)) #Note: In rspec, profile_url = "./fixtures/student-site/students/joe-burgess.html"
     #Now, I want to scrape Joe Burgess' page for all of the relevant bio data,
    links_array = doc.css("div.social-icon-container a").collect do |student_info|
    student_info.attribute("href").value
    end
    links_array.each do |link|
      if link.include?("twitter.com")
        student_links[:twitter] = link
      elsif link.include?("github.com")
        student_links[:github] = link
      elsif link.include?("linkedin")
        student_links[:linkedin] = link
      else
        student_links[:blog] = link
      end
    end
    student_links[:bio] = doc.css("div.description-holder p").text
    student_links[:profile_quote] = doc.css("div.profile-quote").text
    student_links
  end

end
