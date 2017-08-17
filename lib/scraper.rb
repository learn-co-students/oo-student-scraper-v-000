require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url))

      students = []

      doc.css("div.roster-cards-container").each do |card|
        card.css(".student-card a").each do |student|
          student_name = student.css(".student-name").text
          location = student.css(".student-location").text
          url = student.attr("href")
          students << {name: student_name, location: location, profile_url: url}
        end
      end
      students
    end

    def self.scrape_profile_page(profile_url)
    	profile = Nokogiri::HTML(open(profile_url))

    	student = {}

    	links = profile.css("div.social-icon-container a").collect {|x| x.attribute("href").value}

      links.each do |link|
        case
        when link.include?("github")
          student[:github] = link
        when link.include?("twitter")
          student[:twitter] = link
        when link.include?("linkedin")
          student[:linkedin] = link
        else
          student[:blog] = link
        end
        student[:profile_quote] = profile.css(".profile-quote").text
        student[:bio] = profile.css(".bio-block .description-holder p").text
      end
      student
    end

end
