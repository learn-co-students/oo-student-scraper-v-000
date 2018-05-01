require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.student-card").each do |student|
        student_name = student.css("h4").text
        student_location = student.css("p").text
        student_link = student.css("a").attribute("href").value
    students << {name: student_name, location: student_location, profile_url: student_link}

   end
   students
end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    links = doc.css("div.social-icon-container").css("a").collect do |profile_points|
      profile_points.attribute("href").value
    end

    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("github")
        student_profile[:github] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      else link.include?("blog")
        student_profile[:blog] = link 
      end
    end

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text
    student_profile
  end

end
