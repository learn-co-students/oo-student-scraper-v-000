require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper



  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do |student|
    students_array << { :name => student.css("a .card-text-container .student-name").text,
    :location => student.css("a .card-text-container .student-location").text,
  :profile_url => student.css("a").attr("href").value }
  end
 students_array
end






  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}

    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".bio-content p").text

    doc.css(".social-icon-container a").each do |l|
               link = l["href"]


    if link.include?("linkedin.com")
      student[:linkedin] = link
    elsif link.include?("github.com")
      student[:github] = link
    elsif link.include?("twitter.com")
      student[:twitter] = link
    elsif link.include?("youtube.com")
      student[:youtube] = link
    else
      student[:blog] = link
     end
    end
    student
  end
  
end
