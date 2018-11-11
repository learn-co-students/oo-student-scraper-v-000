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
        individual_student = {}
        html = open(profile_url)
        index = Nokogiri::HTML(html)
        student_biodeets = index.css(".social-icon-container").children.css("a")

        student_biodeets.each do |student|
          links = student.values
            if links.include?("twitter")
              individual_student[:twitter] = links
            elsif links.include?("linkedin")
              individual_student[:linkedin] = links
            elsif links.include?("github")
              individual_student[:github] = links
            else
              individual_student[:blog] = links
              end #ends if
          end #ends iteration

        #profile quote
        individual_student[:profile_quote] = index.css(".profile-quote").text
        #bio
       individual_student[:bio] = index.css(".description-holder p").text

       individual_student
       binding.pry
      end #ends method


    end #ends class
