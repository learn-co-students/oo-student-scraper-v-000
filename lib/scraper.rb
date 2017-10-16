
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url = "http://students.learn.co/")
    index_page = Nokogiri::HTML(open("http://students.learn.co/"))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        #binding.pry
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.first_element_child.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
  end
  students
end

def self.scrape_profile_page(profile_url)
  student = {}
  profile_page = Nokogiri::HTML(open(profile_url))
  links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
  links.each do |link|
    if link.include?("linkedin")
      student[:linkedin] = link
    elsif link.include?("github")
      student[:github] = link
    elsif link.include?("twitter")
      student[:twitter] = link
    else
      student[:blog] = link
    end
  end

  student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

  student
  end
end
