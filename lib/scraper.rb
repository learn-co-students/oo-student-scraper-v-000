require 'open-uri'
require 'pry'
require 'nokogiri' #will create a nested structure. Can iterate over this.

#Nokogiri is a ruby gem that transforms webpage into Ruby document

class Scraper

  def self.scrape_index_page(index_url) #scrapes the index page
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))

    #return an array of hashes
    #each hash is a student
    #each student has a name, location, and link
    student_index_array = []
    #initially create a hash for each student. Then put them in an array.
    #find closest unique ancestor
      doc.css(".student-card").each do |card|
        single_student = {}
        student_name = card.css(".student-name").text  #.split(/(?<!\s)(?=[A-Z])/).each { |name| puts name}
        student_location = card.css(".student-location").text  #.split(/([A-Z]{2})/).each { |location| puts location }
        student_url = card.css("a").attr("href").value  #.map { |anchor| anchor['href'] }

        single_student[:name] = student_name
        single_student[:location] = student_location
        single_student[:profile_url] = student_url
        student_index_array << single_student

      end
      student_index_array
    end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url)) #uses open uri module
    scraped_student = {}

    links = doc.css(".social-icon-container").css("a").map { |ans| ans["href"]}
    links.each do |link|

      if link.include?("twitter")
        scraped_student[:twitter] = link
      elsif link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      else
        scraped_student[:blog] = link

      end
    end
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".description-holder").css("p").text
    
    scraped_student
  end
end
