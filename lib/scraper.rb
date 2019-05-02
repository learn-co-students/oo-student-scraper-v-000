require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

  doc = Nokogiri::HTML(open(index_url))

  array = doc.css(".roster-cards-container .student-card")

  students = []

  array.each do |student|
    student_scraped = {
    :name => student.css(".student-name").text,
    :location => student.css(".student-location").text,
    :profile_url => student.css("a").attribute("href").value

  }
  students << student_scraped
  end
  students
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    github = ""
    linkedin = ""
    blog = ""
    twitter = ""

    social_links = doc.css(".social-icon-container a")

    social_links.each do |link|
      if link["href"].include?("github")
        github = link["href"]

      elsif link["href"].include?("twitter")
        twitter = link["href"]

      elsif link["href"].include?("linkedin")
        linkedin = link["href"]

      elsif link["href"].include?(".com")
        blog = link["href"]
      end
    end



    student_scraped = {
      :linkedin => linkedin!= "" ? linkedin : "", #checks to see if the social site is provided
      :blog => blog!= "" ? blog : "",             #checks to see if the social site is provided
      :twitter => twitter!= "" ? twitter : "",    #checks to see if the social site is provided
      :github => github!= "" ? github : "",
      :profile_quote => doc.css(".profile-quote").text, #extract profile quote
      :bio => doc.css(".description-holder p").text  #information inside the paragraph              #checks to see if the social site is provided

    }
      student_scraped.delete_if {|key, value| value == ""}
  end

end
