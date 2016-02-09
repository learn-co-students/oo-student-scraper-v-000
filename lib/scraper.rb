require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css("div.student-card").collect do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      profile = {}

      doc.css(".social-icon-container a").each do |http|
        text_link = http.attribute("href").text
          if text_link.include?("linkedin")
            profile[:linkedin] = text_link 
          elsif
          if text_link.include?("twitter")
            profile[:twitter] = text_link 
          elsif text_link.include?("github")
            profile[:github] = text_link
          elsif http.css("img").attribute("src").text.include?("rss")
            profile[:blog] = text_link
          end
        end
      end
      profile[:profile_quote] = doc.css("div.profile-quote").text
      profile[:bio] = doc.css("div.description-holder p").text
      profile  
  end

end

