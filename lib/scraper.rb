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
    #binding.pry
      doc.css(".social-icon-container").children.css("a").each do |social|
      #binding.pry
      if social.attr("href").include?("twitter")
        student_hash[:twitter] = social.attr("href")
      elsif social.attr("href").include?("linkedin")
        student_hash[:linkedin] = social.attr("href") 
      elsif social.attr("href").include?("github")
        student_hash[:github] = social.attr("href")
      else 
        student_hash[:blog] = social.attr("href")
      end
      #if (".vitals-text-container")
      doc.css(".vitals-text-container").each do |quote|
        student_hash[:profile_quote] = quote.css(".profile-quote").text 
      doc.css(".details-container").each do |bio|
        student_hash[:bio] = bio.css(".bio-content p").text 
      end
    end
  end
      student_hash
end
end