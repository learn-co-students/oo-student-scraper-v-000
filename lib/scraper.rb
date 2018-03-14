require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array=[] #created a new array so that we can push the student hash into it
    html=open(index_url) #used Open-Uri to pull the html of the site
    doc=Nokogiri::HTML(html) #Use Nokogiri and it's HTML method to convert html string into nested nodes and set it to doc variable for simplicity
    student = doc.css('.student-card') #set the CSS selector that locates the infromation we want to iterate over to student variable for simplicity

    student.each do |student| #iterate student variable set above
      student_hash = { #created a new hash to make it easier to add it to the array
        :name =>student.css('.student-name').text, #the name of the student uses CSS class selector of student-name
        :location => student.css('.student-location').text, #the location fo teh student is set to the CSS class selector of student-location
        :profile_url => student.css('a').attribute('href').value
      }
      students_array << student_hash
    end
    students_array
  end


  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student_info[:bio] = student_profile.css('.description-holder p').text
    student_info[:profile_quote] = student_profile.css('.profile-quote').text
    student_profile.css('.social-icon-container a').each do |link|
      if link["href"].include?("twitter")
        student_info[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        student_info[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        student_info[:github] = link["href"]
      else
      student_info[:blog] = link["href"]
      end
    end
    student_info
  end

end
