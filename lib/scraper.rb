require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url)) #grabs the HTML that
    #makes up index_url and then uses the Nokogiri::HTML method
    #to convert it to a NodeSet that we can use. Save it in doc.
    #binding.pry
    scraped_students = []
    doc.css(".student-card").each do|student|
      scraped_students <<{
      :name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css("a").attr("href").value
    }
    end
     scraped_students
    end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    profile_info = []

    student_info = doc.css("#student_info .vitals-container .vitals-text-container .description-holder .profile-quote")
    student_info.each do |information|
      puts "Linkedin: " + student_info.css("a href").value
      puts "github: " + student_info.css("a href").value
      puts "blog: " + student_info.css("a href").value
      puts "Profile Quote: " + profile-quote.css.text
      puts "Bio: " + discription-holder.css.text
    end
  end
end
