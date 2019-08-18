require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#scrapes the student index page ('./fixtures/student-site/index.html') and
#a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
#all students in an array
    all_students = []
#grabs and stores the HTML of the site into a variable called html
#take the string of HTML and converts it into a NodeSet
    doc = Nokogiri::HTML(open(index_url))
#returns each value of the array (name, location and url)
    doc.css(".student-card a").each do |students|
#uses "h4" tag to get student name
      student_name = students.css("h4").text
#uses "p" tag to get the student's location
      student_location = students.css("p").text
#uses "href" to get student's profile url
      student_profile_url = "#{students.attr('href')}"
#shovels those three attributes to scraped_students
      all_students << {name: student_name,
        location: student_location,
        profile_url: student_profile_url}
    end
    all_students
  end


#scrapes a student's profile page and returns a hash of attributes
#describing an individual student
  def self.scrape_profile_page(profile_url)
#Scraped student in a hash
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))
#uses "profile-quote" to get the quote
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
#uses "p" to get bio
    scraped_student[:bio] = doc.css(".description-holder").css("p").text
    urls = doc.css('.social-icon-container a[href]')
#saves the social container urls in an array
    url_array = []
    urls.each do |url|
      if url['href'].include? "twitter"
        scraped_student[:twitter] = url['href']
      elsif url['href'].include?("linkedin")
        scraped_student[:linkedin] = url['href']
      elsif url['href'].include?("github")
        scraped_student[:github] = url['href']
      else
        scraped_student[:blog] = url['href']
      end
    end
    scraped_student
  end

end
