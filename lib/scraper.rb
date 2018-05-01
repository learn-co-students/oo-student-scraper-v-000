require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  def self.get_page
    Nokogiri::HTML(open("./fixtures/student-site/index.html"))
  end
  
  def self.get_page_2
    Nokogiri::HTML(open("./fixtures/student-site/students/joe-burgess.html"))
  end
  def self.scrape_index_page(index_url)
    doc = self.get_page
    array = []
    doc.css(".student-card").each do |student|
    hash_student = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css("a").attribute("href").value
    }
      array.push(hash_student)
  end
  array
end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry
    #doc.css(".social-icon-container a").attribute("//twitter.com/").value
    doc.css(".social-icon-container").each do |social|
      if social != nil
        student_hash[:twitter] = social.css("a")[0].text
        student_hash[:linkedin] = social.css("a")[1].attr("href").value 
        student_hash[:github] = social.css("a")[2].attr("href").value 
        student_hash[:blog] = social.css("a")[3].attr("href").value 
      end
    doc.css(".vitals-text-container").each do |quote|
      if quote != nil 
        student_hash[:profile_quote] = quote.css(".profile-quote").text 
      end
    doc.css(".details-container").each do |bio|
      if bio != nil
        student_hash[:bio] = bio.css(".bio-content p").text 
      end
     end
      end
    end
    student_hash
  end
end