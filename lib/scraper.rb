require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    array = []
    doc.css(".student-card").each do |student|
      students = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      array << students
    end 
    array 
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    test = doc.css(".social-icon-container a")
    test.each do |a|
      # binding.pry
      if a.attr("href").include?("twitter")
        student[:twitter] = a.attr("href")
      elsif a.attr("href").include?("linkedin")
        student[:linkedin] = a.attr("href")
      elsif a.attr("href").include?("github")
        student[:github] = a.attr("href")
      else 
        student[:blog] = a.attr("href")
      end 
    end 
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css("p").text
    
    # student = {
    # :twitter => @twitter,
    # :linkedin => @linkedin,
    # :github => @github,
    # :blog => @blog,
    # :profile_quote => doc.css(".profile-quote").text,
    # :bio => doc.css("p").text
    # }
    
    student
  end

end

