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
    scraped_student={}
    profile_page = Nokogiri::HTML(open(profile_url))

    scraped_student[:bio] = profile_page.css("div.description-holder p").text
    scraped_student[:profile_quote] = profile_page.css("div.profile-quote").text

    # creates an array of web_links to confirm content
    links =  profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}

      links.each do |link|
        if link.include?("twitter")
        scraped_student[:twitter]= link
        elsif link.include?("linkedin")
          scraped_student[:linkedin]= link
        elsif link.include?("github")
          scraped_student[:github]= link
        else
          scraped_student[:blog]= link
        end
      end
    scraped_student
  end

end
