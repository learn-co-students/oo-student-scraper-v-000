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
        student_biodeets = index.css(".social-icon-container").children.css("a")

        student_biodeets.each do |student|
          links = student.valuess
            if links.include? 'twitter'
              links == twitter
            elsif links.include? 'linkedin'
              links == linkedin
            elsif links.include? 'github'
              links == github
            else
              links == blog_name
            end #ends if
          end #ends iteration

      #   individual_student << {twitter: twitter, linkedin: linkedin, github: github}

        return individual_student
      end #ends method



    end #ends class
