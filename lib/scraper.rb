require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students=[]
    doc = Nokogiri::HTML(open(index_url))
    num_of_students = doc.css(".student-card").length #.each do |card|
    (0..num_of_students-1).each do |i|
      student_hash = {:name => "", :location => "", :profile_url => ""}
      student_hash[:name] = doc.css(".card-text-container .student-name")[i].text
      #binding.pry
      student_hash[:location] = doc.css(".card-text-container .student-location")[i].text
      student_hash[:profile_url] = "./fixtures/student-site/#{doc.css(".roster-cards-container a")[i]["href"]}"
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a")
    (0..links.length-1).each do |i|
      current_link = links[i]["href"]
      if current_link.match(/twitter/)
        student[:twitter] = current_link
      elsif current_link.match(/linkedin/)
        student[:linkedin] = current_link
      elsif current_link.match(/github/)
        student[:github] = current_link
      else
        student[:blog] = current_link
      end
    end # end links each do
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text
    student
  end

end
