require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))

    students = []
    
    doc.css(".student-card").each do |student|
      
      index = index_url.sub("index.html", "")
      students << {
        :name => student.css("a .card-text-container h4").text,
        :location => student.css("a .card-text-container p").text,
        :profile_url => index + student.css("a").attribute("href").value
      }
    end
     
    students
   

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))

    student = Hash.new
    links = []

    doc.css(".social-icon-container a").map do |container|
      links << container.attribute("href").value
    end
   
    links.each do |x|
      if x.include?("twitter")
        student[:twitter] = x
      elsif x.include?("linked")
        student[:linkedin] = x
      elsif x.include?("github")
        student[:github] = x
      else
        student[:blog] = x
      end
      links
     end
    links

    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
      
    student

  end
  scrape_profile_page("http://students.learn.co/students/steve-frost.html")

end
