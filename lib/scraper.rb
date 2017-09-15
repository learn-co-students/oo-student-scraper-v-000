require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) #returns an array of hashes in which each hash represents one student
    index_page = Nokogiri::HTML(open(index_url)) #scraped_students = Scraper.scrape_index_page(index_url)
    #binding.pry
    index_page.css(".student-card").collect.with_index do |cards, idx| #list of student profile
      scraped_students = {} #expect(scraped_students).to be_a(Array)
      scraped_students[:name] = index_page.css(".student-name")[idx].text #name of individual student
      scraped_students[:location] = index_page.css(".student-location")[idx].text #location of individual student
      scraped_students[:profile_url] = index_page.css(".student-card a")[idx]["href"] #profile_url of individual student
      scraped_students
    end
  end

  # index_page.css(".roster-cards-container") # collection of students
  # index_page.css(".roster-cards-container").first.css(".student-card a") #list of student profile
  # index_page.css(".roster-cards-container").first.css(".student-card a").attribute("href").value # profile_url of individual student
  # index_page.css(".roster-cards-container").first.css(".student-card a").first.css("h4.student-name").text #name of individual student
  # index_page.css(".roster-cards-container").first.css(".student-card a").first.css("p.student-location").text #location of individual student

  def self.scrape_profile_page(profile_url) #is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
    student_hash = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    #binding.pry
    profile_page.css(".social-icon-container a").each_with_index do |links, idx|
      if links["href"].include?("twitter")
        student_hash[:twitter] = links["href"]
      elsif links["href"].include?("linkedin")
        student_hash[:linkedin] = links["href"]
      elsif links["href"].include?("github")
        student_hash[:github] = links["href"]
      else links["href"].include?("blog")
        student_hash[:blog] = links["href"]
      end
    end
    student_hash[:profile_quote] = profile_page.css(".profile-quote").text
    student_hash[:bio] = profile_page.css(".description-holder p").text
    student_hash
  end

end

# profile_page.css("div.vitals-container").first.css(".social-icon-container a").attribute("href").value #social likes
# profile_page.css("div.vitals-container").first.css(".vitals-text-container .profile-quote").text #profile quote
# profile_page.css("div.details-container").first.css(".description-holder p").text #bio
