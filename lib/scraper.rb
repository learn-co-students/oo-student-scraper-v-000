require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    doc.css("div.social-icon-container").children.css("a").each do |social_media_link|
      temp_link = "#{social_media_link.attr('href')}"
      if temp_link.include?("linkedin")
        linked_in = temp_link
        scraped_student[:linkedin] = linked_in
      elsif temp_link.include?("twitter")
        twitter = temp_link
        scraped_student[:twitter] = twitter
      elsif temp_link.include?("github")
        github = temp_link
        scraped_student[:github] = github
      else
        scraped_student[:blog] = temp_link
      end
    end
    scraped_student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    scraped_student[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
    scraped_student
  end

end
