require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
   doc = Nokogiri::HTML(open(index_url)) 
    #binding.pry
  doc.css(".roster-cards-container").each do |card|
    card.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_url =  "./fixtures/student-site/#{student.attr('href')}"
      students << {:name => student_name, :location => student_location, :profile_url => student_url}
    end
  end
  students
  end
 





  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css(".social-icon-container").each do |profile|
      profile.css("a").each do |link|
        if link.attr('href').include?("linkedin")
          student[:linkedin] = link.attr('href')
        elsif link.attr('href').include?("github")
          student[:github] = link.attr('href')
        elsif link.attr('href').include?("twitter")
          student[:twitter] = link.attr('href')
        else 
          student[:blog] = link.attr('href')
        end
      end 
    student[:profile_quote]= doc.css(".profile-quote").text
    student[:bio] = doc.css("p").text
  end
  student
  #=binding.pry
end 
end


 #{:twitter=>"http://twitter.com/flatironschool",
 #     :linkedin=>"https://www.linkedin.com/in/flatironschool",
 #     :github=>"https://github.com/learn-co,
 #     :blog=>"http://flatironschool.com",
 #     :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 #     :bio=> "I'm a school"
  #   }