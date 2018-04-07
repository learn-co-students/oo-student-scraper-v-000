require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

index_url = "http://67.205.182.198:36006/fixtures/student-site/" #A website address usually is passed as a parameter of open-uri's #open method

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

  end

end
