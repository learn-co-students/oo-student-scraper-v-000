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
   
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

