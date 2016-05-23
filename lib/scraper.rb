require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    ### THIS IS MY WORKING CODE
    # students = page.css("div.student-card").map.with_index do |student, i|
    #   name = page.css("div.student-card div.card-text-container h4.student-name")[i].text
    #   location = page.css("div.student-card div.card-text-container p.student-location")[i].text
    #   url = index_url + page.css("div.student-card a")[i]["href"]

    #   {name: name, location: location, profile_url: url}
    # end

    ### THIS IS THE SOLUTION (LESS REPETITION ==  CLEANER)
    students = []

    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "http://127.0.0.1:4000/#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    ### THIS IS MY WORKING CODE
    # profile_attributes = {}
    # social_links = page.css("div.social-icon-container a")

    # social_links.each do |link|
    #   if link["href"].end_with?(".com/")
    #     profile_attributes[:blog] = link["href"] 
    #   elsif link["href"].match(/https:\/\/twitter.com/)
    #     profile_attributes[:twitter] = link["href"]
    #   elsif link["href"].match(/https:\/\/.+in/)
    #     profile_attributes[:linkedin] = link["href"]
    #   elsif link["href"].match(/https:\/\/github.com/)
    #     profile_attributes[:github] = link["href"]
    #   end
    # end

    # profile_attributes[:profile_quote] = page.css("div.profile-quote").text
    # profile_attributes[:bio] = page.css("div.bio-content div.description-holder p").text

    # profile_attributes 

    ### THIS IS THE SOLUTION
    student = {}
    links = page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
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
    student[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
    student[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if page.css("div.bio-content.content-holder div.description-holder p")

    student
  end


end

