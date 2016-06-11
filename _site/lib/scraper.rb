require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #Scrapes URL passed in
    index = Nokogiri::HTML(open(index_url))
    
    #Creates student array  to store hash
    students = []

    #Enters into container holding student cards
    index.css(".roster-cards-container").each do |card|
      #Enters into each student card
      card.css(".student-card a").each do |student|
        
        #Saves student link, location, and name
        student_link = "http://127.0.0.1:4000/#{student.attr("href")}"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
         
        #Puts those saved variables into hash, and saves into student array    
        students << {name: student_name, location: student_location, profile_url: student_link}

      end
    end
    #Returns student array
   students
  end


  def self.scrape_profile_page(profile_url)
    
    #Creates student hash to be returned
    student = {}

    #Scrapes profile page
    profile = Nokogiri::HTML(open(profile_url))
    #Grabs social section and sets equal to social
    social = profile.css(".social-icon-container")
    social2 = social.children.css("a")
    #binding.pry
    #Collects all href links because there are more than one social links
    links = social2.collect {|link| link.attribute('href').value}


    #Finds social link and adds into hash if exists
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      else
        student[:blog] = link
      end
    end

    #Adds student bio and profile quote to hash
    student[:bio] = profile.css(".description-holder p").text
    student[:profile_quote] = profile.css("div.profile-quote").text

    #Returns hash
    student
  end


end

