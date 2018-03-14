require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.student-card").map do |profile|
      {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
       }
    end
  end

# Alternative Soln.
#   def self.scrape_index_page(index_url)
#   index_page = Nokogiri::HTML(open(index_url))
#   students = []
#   index_page.css("div.roster-cards-container").each do |card|
#     card.css(".student-card a").each do |student|
#       student_profile_link = "#{student.attr('href')}"
#       student_location = student.css('.student-location').text
#       student_name = student.css('.student-name').text
#       students << {name: student_name, location: student_location, profile_url: student_profile_link}
#     end
#   end
#   students
# end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    media = {}
    profile_page.css("div.social-icon-container a").each do |sns|
      url = sns.attribute("href").value
      if url.match(/twitter|linkedin|github/)
        key = url.match(/twitter|linkedin|github/)[0].to_sym
        media[key] = url
      else
        media[:blog] = url
      end
    end
    media[:profile_quote] = profile_page.css("div.profile-quote").text
    media[:bio] = profile_page.css("div.description-holder p").text
    media
  end

  # alternative solution:
  # def self.scrape_profile_page(profile_slug)
  # student = {}
  # profile_page = Nokogiri::HTML(open(profile_slug))
  # links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
  # links.each do |link|
  #   if link.include?("linkedin")
  #     student[:linkedin] = link
  #   elsif link.include?("github")
  #     student[:github] = link
  #   elsif link.include?("twitter")
  #     student[:twitter] = link
  #   else
  #     student[:blog] = link
  #   end
  # end
  # # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
  # # # if profile_page.css(".social-icon-container").children.css("a")[0]
  # # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
  # # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
  # # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
  # student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  # student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
  #
  # student

end



# Scraper.scrape_index_page(index_url)
# # => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
# {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
# {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
# {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
# ]

# Scraper.scrape_profile_page(profile_url)
# # => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      }
