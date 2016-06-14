require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
#  index_url = "http://127.0.0.1:4000/"  #for test
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    roster_cards = doc.css(".roster-cards-container")

#    roster_cards.css("h4").collect { |n| {:name => n.text} }
    roster_cards.css(".student-card").collect do |student|
      {:name => student.css("h4").text,
       :location => student.css("p").text,
       :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"}
    end



  end

#  binding.pry    Scraper.scrape_profile_page("http://127.0.0.1:4000/fixtures/student-site/students/joe-burgess.html")

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hyperlinks = doc.css("a")
    hyperlinks_array =[]
    hyperlinks.each do |hyperlink|
      hyperlinks_array << hyperlink.attribute("href").value
    end

    a_twitter = hyperlinks_array.detect {|w| w.split("/").include?("twitter.com") }
    a_linkedin = hyperlinks_array.detect {|w| w.split("/").include?("www.linkedin.com") }
    a_github = hyperlinks_array.detect {|w| w.split("/").include?("github.com") }
    a_blog = hyperlinks_array[-1]
    a_profile_quote = doc.css(".profile-quote").text
    a_bio = doc.css(".bio-content .description-holder").text.strip

    { :twitter => a_twitter,
      :linkedin => a_linkedin,
      :github => a_github,
      :blog => a_blog,
      :profile_quote => a_profile_quote,
      :bio => a_bio}
  #  end
#   hyperlinks_array
#   hyperlinks.collect {|hyperlink| hyperlink.attribute("href").value} # == "../assets/img/rss-icon.png"}
   end
#binding.pry
end


# Scraper.scrape_profile_page(profile_url)
#  => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      }



# html = open("http://flatironschool.com/team")
# doc = Nokogiri::HTML(html)
#
# instructors = doc.css("#instructors .team-holder .person-box")
#
# instructors.each do |instructor|
#   puts "Flatiron School <3 " + instructor.css("h2").text
# end

# def make_courses
#   self. get_courses.each do |post|
#      course = Course.new
#      course.title = post.css("h2").text
#      course.schedule = post.css(".date").text
#      course.description = post.css("p").text
#   end
# end

# def create_project_hash
#   html = File.read('fixtures/kickstarter.html')
#   kickstarter = Nokogiri::HTML(html)
#
#   projects = {}
#
#   kickstarter.css("li.project.grid_4").each do |project|
#     title = project.css("h2.bbcard_name strong a").text
#     projects[title.to_sym] = {
#       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#       :description => project.css("p.bbcard_blurb").text,
#       :location => project.css("ul.project-meta span.location-name").text,
#       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#     }
#   end
#
#   # return the projects hash
#   projects
# end
