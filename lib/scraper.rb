require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = doc.css(".student-card").each do |student|
      name = student.css("h4").text
      location = student.css("p").text
      profile_url = student.css("a").attribute("href").value
      student_list << {:name => name, :location => location, :profile_url => profile_url}
     end 
    # binding.pry
   student_list
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    student_page = Nokogiri::HTML(open(profile_url))
    social_media_links = student_page.css(".social-icon-container").children.css("a").map {|x| x.attribute("href").value}
  
    social_media_links.each do |link|
   #   binding.pry
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
      student[:profile_quote] = student_page.css(".profile-quote").text
      student[:bio] = student_page.css(".description-holder p").text
    #  binding.pry
    student
    end
   

end
