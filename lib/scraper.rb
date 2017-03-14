require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new

    doc.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
      students.push({:name => student_name, :location => student_location, :profile_url => student_profile_link})
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student = Hash.new

    #bio
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text

    #quote
    student[:profile_quote] = doc.css(".profile-quote").text

    #links
    links = doc.css(".social-icon-container a").map {|a| a.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end

    student
  end

end
