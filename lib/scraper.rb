require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-body-wrapper").each do |student_card|
      student_card.css("div.student-card a").each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      student_link = "#{student.attr('href')}"
      students << { name: student_name, location: student_location, profile_url: student_link }
      end
    end
    students
  end

  #:name, :location and :profile_url.

  #:twitter=>"http://twitter.com/flatironschool",
  # :linkedin=>"https://www.linkedin.com/in/flatironschool",
  # :github=>"https://github.com/learn-co",
  # :blog=>"http://flatironschool.com",
   #:profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  # :bio=> "I'm a school"
  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css("div.social-icon-container")
    links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
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
    student[:profile_quote] = profile.css("div.vitals-text-container div.profile-quote").text
    if profile.css("div.vitals-text-container")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text
    if profile.css("div.bio-content.content-holder div.description-holder p")
    student
  end

end






  end

end
