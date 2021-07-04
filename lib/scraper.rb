require 'open-uri'
require 'pry'



class Scraper

  # def self.scrape_index_page(index_url)
  #   doc = Nokogiri::HTML(open(index_url))
  #   students = []
  #   doc.css(".student-card").each do |roster_card|
  #   student_name = roster_card.css(".h4").text
  #   student_location = roster_card.css("p").text
  #   student_profile = roster_card.css("a").text
  #  students << {name: student_name, location: student_location, profile_url: student_profile}
  #      end
  #    end

     def self.scrape_index_page(index_url)
       students = []
       index_page = Nokogiri::HTML(open(index_url))
       index_page.css("div.roster-cards-container").each do |roster_card|
         #adding "a" to the css selector finds all anchor elements (i.e.href elements)
         roster_card.css(".student-card a").each do |student_card|
           student_name = student_card.css('.student-name').text
           student_location = student_card.css('.student-location').text
           student_profile_link = "#{student_card.attr('href')}"
           students << {name: student_name, location: student_location, profile_url: student_profile_link}
        end
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    social_link = profile_page.css('.social-icon-container a').map { |links| links['href']}
    social_link.each do |link|
  if link.include?("github")
    student[:github] = link
  elsif link.include?("linkedin")
    student[:linkedin] = link
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
