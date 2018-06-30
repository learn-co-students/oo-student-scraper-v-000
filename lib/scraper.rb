
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students_array = []
    doc.css(".roster-cards-container").each do |roster|

      roster.css(".card-text-container").each do |student|

    stu_name = student.css(".student-name").text
    stu_location = student.css(".student-location").text


     roster.css(".student-card").each do |student|
       stu_profile_url = student.css("a")[0].attribute("href").value

      students_array << {name: stu_name, location: stu_location, profile_url: stu_profile_url}
    end
   end
  end
   students_array
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    #binding.pry

    student_profile = {}

      social = profile_page.css(".social-icon-container").css("a")


      social.each do |links|

    if links.attribute("href").value.include? ("twitter")
    student_profile[:twitter] = links.attribute("href").value
  elsif links.attribute("href").value.include? ("linkedin")
    student_profile[:linkedin] = links.attribute("href").value
  elsif links.attribute("href").value.include? ("github")
    student_profile[:github] = links.attribute("href").value
  else
    student_profile[:blog] = links.attribute("href").value
   end
  end

    student_profile[:profile_quote] = profile_page.css(".profile-quote").text
    student_profile[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text

  student_profile

 end

end
