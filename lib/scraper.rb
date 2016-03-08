require 'pry'
require 'open-uri'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    name = ""
    location = ""
    profile_url = ""

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each do |i| 
    students << {
    name: i.css("h4.student-name").text,
    location: i.css("p.student-location").text, 
    profile_url: "http://127.0.0.1:4000/fixtures/student-site/#{i.css("a").first["href"]}"
   }
      end
    students
  end


  def self.scrape_profile_page(profile_url)





    
  end

end

