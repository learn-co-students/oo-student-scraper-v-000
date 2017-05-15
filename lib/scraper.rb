require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.css(".student-card").each do |card|
      students << {name: card.css("h4.student-name").text, :location => card.css("p.student-location").text, profile_url: card.css("a").attribute("href").value}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}


    doc.css("div.social-icon-container a").each do |icon|
      if icon.css(".social-icon").attribute("src").value[/twitter/]
        student_info[:twitter] = icon.attribute("href").value
      end
      if icon.css(".social-icon").attribute("src").value[/linkedin/]
        student_info[:linkedin] = icon.attribute("href").value
      end
      if icon.css(".social-icon").attribute("src").value[/github/]
        student_info[:github] = icon.attribute("href").value
      end
      if icon.css(".social-icon").attribute("src").value[/rss/]
        student_info[:blog] = icon.attribute("href").value
      end #end if/else
    end#end each

    student_info[:profile_quote] = doc.css("div.profile-quote").text
    student_info[:bio] = doc.css("div.description-holder p").text

    student_info
  end

end
