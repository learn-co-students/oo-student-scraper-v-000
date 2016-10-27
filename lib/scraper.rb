require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        students << {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end  
    end  
    students
  end

  def self.scrape_profile_page(profile_url)
   html = Nokogiri::HTML(open(profile_url))  
    social_collection = html.css("div.social-icon-container").children.css("a").map {|e| e.attribute("href").value} 
    student = {}
    social_collection.each do |link|
      # name = '' 
      # to_be_deleted = link.match(/^(https:\/\/www.)|(https:\/\/)|(http:\/\/)/)[0]
      # i = link.gsub(to_be_deleted, '')
      # j = i.slice!(0...i.index('.'))

      # if j.match(/^(twitter)|(github)|(linkedin)/)
      #   to_be_named = j.match(/^(twitter)|(github)|(linkedin)/)
      #   attribute_name = to_be_named[0]
      # else
      #   attribute_name = "blog"
      # end
      # if attribute_name
      #   student[attribute_name.to_sym] = link
      # end

      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end    
    end	

	  student[:profile_quote] = html.css("div.profile-quote").text if html.css("div.profile-quote")
	  student[:bio] = html.css("div.bio-content .description-holder p").text if html.css("div.bio-content .description-holder p")
    student
  end 
  
end

