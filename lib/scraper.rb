require 'nokogiri'
require 'pry'
      #in this lab we are not using the below requirement because the html information is not coming from a live website, but from a local files
require "open-uri"

class Scraper
  #The #scrape_index_page method is responsible for scraping the index page that lists all of the students


     def self.scrape_index_page(index_url)
        #html = File.read(index_url)
        #document = Nokogiri::HTML(html)
        #rather than writing the below line of code, you could just write the above 2 lines
        document = Nokogiri::HTML(open(index_url))

        student_array =[]
        #isolate the code that has each individual student
        document.css(".student-card").each do |card|
          #create a blank hash for each student that
          student_hash = {}
          student_hash =  {
          :name => card.css(".student-name").text,
          :location => card.css(".student-location").text,
          :profile_url => card.css("a").attr('href').text  }
          ##A note ON .ATTRIBUTE An image tag in HTML is considered to have a source attribute. In the following example <img src="http://www.example.com/pic.jpg"> the source attribute would be "http://www.example.com/pic.jpg". You can use the .attribute method on a Nokogiri element to grab the value of that attribute.
          student_array << student_hash
        end
        student_array
      end

  #the #scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student.
  def self.scrape_profile_page(profile_url)
      student = {}
      #breakdown the profile page into a Nokogiri HTML doc
      student_profile = Nokogiri::HTML(open(profile_url))
      #make an array, at the social icon container, .children accesses that children with "a" and by mapping we will have those values in a new array, for each link, we want the value of the href
      links = student_profile.css(".social-icon-container").children.css("a").map {|x| x.attribute("href").value}

      links.each do |link|
            if link.include?("linkedin")
                    #replace the element that we are enumerating over a hash element for student
                   student[:linkedin] = link
                  elsif link.include?("github")
                     student[:github] = link
                  elsif link.include?("twitter")
                      student[:twitter] = link
                  else
                     student[:blog] = link
             end
      end
      student[:profile_quote] = student_profile.css(".profile-quote").text if student_profile.css(".profile-quote")
      student[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text if student_profile.css("div.bio-content.content-holder div.description-holder p")
      student
  end
end


# => {:twitter=>"http://twitter.com/flatironschool",
#      :linkedin=>"https://www.linkedin.com/in/flatironschool",
#      :github=>"https://github.com/learn-co,
#      :blog=>"http://flatironschool.com",
#      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#      :bio=> "I'm a school"
#     }

profile_url = "./fixtures/student-site/students/joe-burgess.html"
scraped_student = Scraper.scrape_profile_page(profile_url)
scraped_student
