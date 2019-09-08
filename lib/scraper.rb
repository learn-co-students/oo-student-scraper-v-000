require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    new_array = []
    doc.css(".student-card").each_with_index do |student, index|
      student_name = doc.css(".student-name")[index].text
      location = doc.css(".student-location")[index].text
      url = doc.css("a")[index + 1].attributes["href"].value #+1 b/c first one is logo, not link
      new_array << {:name => student_name, :location => location, :profile_url => url}
    end
    new_array
  end

  def self.scrape_profile_page(profile_url)
    #BETTER SOLUTION =>
    #doc.css.(".social-icon-container a").each do |student| #look at white bar in dev tools with students to get this
      #link = student.attributes["href"].value #in pry with students try to access diff keys to get to this-student is just a hash
    #check if link includes github etc.
    #end
    #class method b/c not storing anything
    doc = Nokogiri::HTML(open(profile_url))
    students = {}
    links = doc.css("a")
    links.each do |link|
      if link.attributes["href"].value.include?("twitter") #don't need index after link b/c it's already one iteration
        students[:twitter] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("linkedin")
        students[:linkedin] = link.attributes["href"].value
      elsif link.attributes["href"].value.include?("github")
        students[:github] = link.attributes["href"].value
      elsif link.attributes["href"].value.scan(/\w/) != [ ] #trying to scan for letters and leave out .../
         students[:blog] = link.attributes["href"].value
      end
      students[:profile_quote] = doc.css(".profile-quote").text
      students[:bio] = doc.css("p").text #outside of loop b/c don't need to check for these 
    end
    students
  end





end
