require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc= Nokogiri::HTML(html)
    students =[]
    doc.css(".student-card").each do |student|
    students << {:name => student.css(".student-name").text,
    :location => student.css(".student-location").text,
    :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    doc= Nokogiri::HTML(html)
    student= {}
    
    doc.css(".social-icon-container a").each do |urli|
        url=urli.attribute("href").value
      if url.include? "twitter"
        student[:twitter] = url
      elsif url.include? "linkedin"
        student[:linkedin]= url
      elsif url.include? "github"
        student[:github] = url
      else
        student[:blog] = url
      end
    end

      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".description-holder p").text
      student
  end

end

