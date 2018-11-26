require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  # self.scrape_index_page - is responsible for scraping the index page that
  # lists all of the students
  #
  # index_url -> "./fixtures/student-site/index.html"
  def self.scrape_index_page(index_url)
    # Open-URI to access that page
    # Nokogiri is an open source software library
    # to parse HTML and XML in Ruby. Set that to the varable
    # student_index_page
    student_index_page = Nokogiri::HTML(open(index_url))
    students = []
    student_index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attribute('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
        # require 'pry'
        # binding.pry
      end
    end

students
# require 'pry'
# binding.pry

  end

  # self.scrape_profile_page - is responsible for scraping an individual student's
  # profile page to get further information about that student.
  # profile_url -> "./fixtures/student-site/students/someones_firstname-someones_lastname.html"
  # sml - would stand for "social media link", fyi
  def self.scrape_profile_page(profile_url)
    student_profile_page = Nokogiri::HTML(open(profile_url))
    profiles = {}
    student_profile_page.css(".social-icon-container").each do |sml|
      sml.css("a").each do |link|
            if link.attributes["href"].value.include?("linkedin")
              # linkedin is
              profiles[:linkedin] = link.attributes["href"].value
            #  binding.pry
            elsif link.attributes["href"].value.include?("github")
              profiles[:github] = link.attributes["href"].value
               #binding.pry
            elsif link.attributes["href"].value.include?("twitter")
               profiles[:twitter] = link.attributes["href"].value
              #binding.pry
            else

              profiles[:blog] = link.attributes["href"].value
            #  binding.pry
           end

        end
        # bio
    student_profile_page.css(".details-container").each do |sml|

          profiles[:bio] = sml.css("p").children.text
          #binding.pry
        end
    # profile_quote
    student_profile_page.css(".vitals-text-container").each do |sml|
      #binding.pry
          profiles[:profile_quote] = sml.css("div.profile-quote").text
        end
     end
     profiles
   end

end
# elsif link.attributes["href"].value.include?("bio")
#     profiles[:bio] = link.attributes["href"].value
# elsif link.attributes["href"].value.include?("profile_quote")
#     profiles[:profile_quote] = link.attributes["href"].value
