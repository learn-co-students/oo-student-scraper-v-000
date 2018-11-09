require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio



  def self.scrape_index_page(index_url)
      students = []
      html = open(index_url)
      index = Nokogiri::HTML(html)
      student_card = index.css(".student-card a")
      #student_name = student_card.css(".student-name").text
      #student_location = student_card.css(".student-location").text
      #student_url = student_card.css("a").attribute("href").text
      student_card.each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.attribute("href").text
        students << {name: student_name, location: student_location, profile_url: student_url}
        #binding.pry
      end
        return students
      end

      def self.scrape_profile_page(profile_url)
        individual_student = []
        html = open(profile_url)
        index = Nokogiri::HTML(html)
        #student_biodeets = index.css(".description-holder").text
        student_biodeets = index.css(".main-wrapper.profile")

        student_biodeets.each do |student|
          twitter = student.attibute("social-icon-container")
          #linkedin = student.css("p").text
          #github = student.css("p").text
          #student_experience = student.css("p").text
          #blog_name = student.css("h4").text
          #profile_quote = student.css("h5").text
          #bio = student.css("h5").text
          binding.pry

        #  individual_student << {twitter: twitter, linkedin: linkedin, github: github, :blog blog_name,
        #    :profile_quote profile_quote, bio: bio}
        end
        #  return individual_student
      end #ends method


    end #ends class
