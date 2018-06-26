require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	#{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}
    html = File.read(index_url)

    scrape_index_page = Nokogiri::HTML(html)
    
    students_array = []

    scrape_index_page.css("div.student-card, #id").each do |student|
		student_hash = {}

		name = student.css("h4.student-name").text
		location = student.css("div.card-text-container p.student-location").text
		profile_url = student.css("div.student-card, #id, a").attribute("href").value
    	student_hash[:name] = name
    	student_hash[:location] = location
    	student_hash[:profile_url] = profile_url

    	students_array << student_hash
    end

    students_array
  
  end

  def self.scrape_profile_page(profile_url)
    # return value is a hash in which the key/value pairs are:
    # :twitter => https://twitter.com/empireofryan
    # :linkedin => https://www.linkedin.com/in/ryan-johnson-321629ab
    # :github => https://github.com/empireofryan
    # :blog => 
    # :profile_quote => 
    # :bio =>

    html = File.read(profile_url)

    scrape_profile_page = Nokogiri::HTML(html)

    student_hash = {}

    links = scrape_profile_page.css("div.social-icon-container").children.css("a").map {|element| element.attribute("href").value}

    links.each do |link|
      if link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      elsif link.include?("twitter")
        student_hash[:twitter] = link
      else link.include?("blog")
        student_hash[:blog] = link
      end
    end

    student_hash[:profile_quote] = scrape_profile_page.css("div.profile-quote").text
    student_hash[:bio] = scrape_profile_page.css("div.bio-content content-holder.description-holder, p").text

    student_hash
  end

end

