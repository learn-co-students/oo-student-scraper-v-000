require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    #without period - looking for elment
    page.css(".student-card").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      profile_url = card.css("a").attr("href").value
      students << {name: student_name, location: student_location, profile_url: profile_url}
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = { profile_quote: page.css(".profile-quote").text.strip,
      bio: page.css(".description-holder").css("p").text.strip
    }
    #selects all the links in social icon container
    page.css(".social-icon-container a").each do |icon|
      #binding.pry
      icon_card = icon.attr("href")

      if icon_card.include?("twitter")
        student[:twitter] = icon_card

      elsif icon_card.include?("linkedin")
        student[:linkedin] = icon_card

      elsif icon_card.include?("github")
        student[:github] = icon_card

      elsif icon_card.include?("facebook")
        student[:facebook] = icon_card
      else
        student[:blog] = icon_card
      end
    end
    student
  end
end
