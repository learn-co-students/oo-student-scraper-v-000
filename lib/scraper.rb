require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_link = "#{student.attr('href')}"

        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    student = {}

    profile_page = Nokogiri::HTML(open(profile_url))

     links = profile_page.css(".social-icon-container").children.css("a").map { |url| url.attribute('href').value} #for every child of the social container pull the href attribute's value (the social link) and add to a new array called links

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
