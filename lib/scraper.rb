require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read("./fixtures/student-site/index.html"))
    student_cards = doc.css("div.roster-cards-container").css("div.student-card")

    students = []
    student_cards.each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a")[0]["href"]
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(File.read(profile_url))
    info = {
      profile_quote: doc.css("div.profile-quote").text ,
      bio: doc.css("div.description-holder > p").text
    }
    
    doc.css(".social-icon-container > a").each do |link|
      if link["href"].include?("twitter")
        info[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        info[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        info[:github] = link["href"]
      else
        info[:blog] = link["href"]
      end
    end
    info
  end

end
