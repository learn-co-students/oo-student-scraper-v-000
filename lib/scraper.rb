require 'open-uri'
require 'pry'
require "nokogiri"


class Scraper
  #attr_accessor :profile_url
  #html = File.read('./fixtures/student-site/index.html') #sets the imported HTML(string) equal to a variable, html

  #index_url = Nokogiri::HTML(html) #takes the html variable and converts it into a nested node set

  def self.scrape_index_page(index_url) #responsible for scraping the index page that lists all of the students
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

      doc.css("div.student-card").each do |student|
        scraped_students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
  end
  scraped_students
end

#name doc.css("div.student-card").first.css("h4").text
#location doc.css("div.student-card").first.css("p").text
#profile_url  doc.css("div.student-card").first.css("a").attribute("href").value

  def self.scrape_profile_page(profile_url) #responsible for scraping an individual student's profile page to get further information
    profile_doc = Nokogiri::HTML(open(profile_url))
     #binding.pry
    student_profile = {}

      links = profile_doc.css("div.social-icon-container").children.css("a").collect {|link| link.attribute("href").value}

        links.each do |link|
          if link.include? ("twitter")
            student_profile[:twitter] = link
          elsif link.include? ("linkedin")
            student_profile[:linkedin] = link
          elsif link.include? ("github")
            student_profile[:github] = link
          else student_profile[:blog] = link
          end
        end

      student_profile[:profile_quote] = profile_doc.css("div.profile-quote").text if profile_doc.css("div.profile-quote").text
      student_profile[:bio] = profile_doc.css("div.bio-block p").text if profile_doc.css("div.bio-block p")
  student_profile
end




    # {:twitter=>"http://twitter.com/flatironschool",
    #       :linkedin=>"https://www.linkedin.com/in/flatironschool",
    #       :github=>"https://github.com/learn-co,
    #       :blog=>"http://flatironschool.com",
    #       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #       :bio=> "I'm a school"
    #      }

        # {
        #   :twitter=>
        #   :linkedin=>
        #   :github=>
        #   :blog=>
        #   :profile_quote=>
        #   :bio=>
        #  }

# div.main-wrapper-profile
# #div.vitals-container
# #twitter div.social-icon-container a href (1)
# linkedin div.social-icon-container a href (2)
# github div.social-icon-container a href (3)
# blog div.social-icon-container a href (3)
# profile_quote div.profile-quote
#
# div.details-container
# bio div.bio-block details-block div.description-holder
  #end

end
 #Scraper.scrape_profile_page("./fixtures/student-site/students/danny-dawson.html") #responsible for scraping the index page that lists all of the students
