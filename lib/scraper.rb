require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.search(".student-card").each do |properties|
        student_name = properties.search(".student-name").text
        student_location = properties.search(".student-location").text
        student_page = index_url + '/' + properties.search('a').attribute('href').value

        students << {name: student_name, location: student_location, profile_url:student_page}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    student[:twitter] = doc.search(".social-icon-container").children.search("a")[0].attribute("href").value
    student[:linkedin] = doc.search(".social-icon-container").children.search("a")[1].attribute("href").value
    student[:github] = doc.search(".social-icon-container").children.search("a")[2].attribute("href").value
    student[:bio] = doc.search("div.bio-content.content-holder div.description-holder p").text
    student[:profile_quote] = doc.search(".profile-quote").text

    student


  end

end

