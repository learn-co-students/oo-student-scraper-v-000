require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    learn = Nokogiri::HTML(html)

    students = []

    learn.css("div.student-card").each do |student|
      name = student.css("div.card-text-container h4.student-name").text
      location = student.css("div.card-text-container p.student-location").text
      link = student.css("a").attribute("href").value
      students << {
        :name => name,
        :location => location,
        :profile_url => "#{index_url}#{link}"
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}
    social_media = []
    links = []

    profile.css("div.social-icon-container a").each do |element|
      social_media << element
      social_media.each do |link|
        links << link.attribute("href").value
      end
    end
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile.css("div.profile-quote").text
    student[:bio] = profile.css("div.description-holder p").text
    student
  end


end

#Scraper.scrape_profile_page("http://127.0.0.1:4000/students/ryan-johnson.html")

    # twitter: div.social-icon-container a href includes? twitter
    # linkedin: 



#   Scraper.scrape_profile_page(profile_url)
# # => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      } 


# end

# test = Scraper.new
# Scraper.scrape_index_page("http://127.0.0.1:4000/")



# index_url = "http://127.0.0.1:4000/"
#   html = File.read('fixtures/kickstarter.html')
#   kickstarter = Nokogiri::HTML(html)
  
#   projects = {}

#   kickstarter.css("li.project.grid_4").each do |project|
#     title = project.css("h2.bbcard_name strong a").text
#     projects[title.to_sym] = {
#       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#       :description => project.css("p.bbcard_blurb").text,
#       :location => project.css("ul.project-meta li a span.location-name").text,
#       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#     }
#   end

#   projects
# end