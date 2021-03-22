require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :Student

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    #studnets = page.css("div.student-card")
    # iterate through students to find
    #page.css("div.student-card").first =>Ryans card
    # page.css("div.card-text-container h4").first.text => Ryan's name
    #page.css("div.card-text-container p").first.text => Ryan's location
    #page.css("div.student-card a").first.attribute("href").value

    # binding.pry
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|

        student_href = "#{student.attr("href")}"
        student_location = student.css(".student-location").text
        student_name = student.css('.student-name').text
        # binding.pry
        students << {
          :name => student_name,
          :location => student_location,
          :profile_url => student_href
        # binding.pry
          }
      end
    end
      students
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    links = profile_page.css("social-icon-container").children.css("a").map{ |e| e.atrribute("href").value}
    links.each do |link|

      if link.include?("twitter")
        student[:twitter] = link
      if link.include?("linkedin")
        student[:linkedin] = link
      if link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
        binding.pry
      end
  end
    student[:profile-quote] = profile_page.css(".profile-quote").text if page.css(".profile-quote")
    student[:bio] = profile_page.css("div.description-holder p").text if page.css("div.description-holder p")
    sbinding.pry
    student
    end
  end

  end
end
