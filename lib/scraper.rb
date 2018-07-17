require 'open-uri'
require 'pry'


class Scraper


  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}

          end
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile_page.css(".social-icon-container a").map { |link| link['href'] } # <- this returns an array of social links

    links.each do |link|
      if link.include?("linkedin")
        link = student[:linkedin]
      elsif link.include?("twitter")
        link = student[:twitter]
      elsif link.include?("github")
        link = student[:github]
      else
        link = student[:blog]
      end
    end

    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".description-holder p").text
    student
  end


end
