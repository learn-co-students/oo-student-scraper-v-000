require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  #index.css(".roster-cards-container")
  #index.css(".student-card a")
  #index.css(".student-name").text
  #index.css(".student-location”).text
  #index.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
      index.css(".roster-cards-container").each do |card|
        card.css(".student-card a").each do |student|
          name = student.css(".student-name").text
          location = student.css(".student-location").text
          profile_url = "#{student.attr('href')}"
          students << {name: name, location: location, profile_url: profile_url}
          #binding.pry
        end
end
students
  end

#profile.css(".social-icon-container")
# => {:twitter=>"http://twitter.com/flatironschool",
    #  :linkedin=>"https://www.linkedin.com/in/flatironschool",
    #  :github=>"https://github.com/learn-co,
    #  :blog=>"http://flatironschool.com",
    #  :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #  :bio=> "I'm a school"
    # }

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container a").collect do |url|
      url.attribute("href").value
    end
    social.each do |s|
      if s.include?("twitter")
        student[:twitter] = s
        elsif s.include?("linkedin")
        student[:linkedin] = s
      elsif s.include?("github")
        student[:github] = s
      else s.include?("blog")
        student[:blog] = s
      end
    end
     #binding.pry
     student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
     student[:bio] = profile.css(".bio-content p").text if profile.css(".bio-content p")

student
  end

end
