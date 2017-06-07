require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  # def self.scrape_index_page(index_url)
  #   students = []
  #
  #   self.get_page(index_url).css('.student-card').each do |s|
  #     student = {}
  #     student[:name] = s.css('.card-text-container h4.student-name').text
  #     student[:location] = s.css('.card-text-container p.student-location').text
  #     student[:profile_url] = index_url + '/' + s.css('a').attribute('href').value
  #     students << student
  #   end
  #
  #   students
  # end
  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))
     scraped_students = []
     doc.css(".student-card").each do |student|
       scraped_students << {
         name: student.css("h4.student-name").text,
         location: student.css("p.student-location").text,
         profile_url: './fixtures/student-site/' + student.css("a").attr('href').value #{student.attr('href')
        }
      end
      scraped_students
    end

  def self.scrape_profile_page(profile_slug)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
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
  # def self.scrape_profile_page(profile_slug)
  #   doc = Nokogiri::HTML(open(profile_slug))
  #   scraped_student = {}
  #   doc.css(".social-icon-container a").each do |link|
  #     normalized_link = link.attribute("href").text
  #     scraped_student[:twitter] = normalized_link if normalized_link.include?("twitter")
  #     scraped_student[:linkedin] = normalized_link if normalized_link.include?("linkedin")
  #     scraped_student[:github] = normalized_link if normalized_link.include?("github")
  #     scraped_student[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
  #   end
  #   scraped_student[:profile_quote] = doc.css(".profile-quote").text
  #   scraped_student[:bio] = doc.css("bio-content .description-holder p").text
  #
  #   scraped_student
  #  end
end




# require 'open-uri'
# require 'pry'
#
# class Scraper
#
#   def self.scrape_index_page(index_url)
#     index_page = Nokogiri::HTML(open(index_url))
#     students = []
#     index_page.css("div.roster-cards-container").each do |card|
#       card.css(".student-card a").each do |student|
#         student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
#         student_location = student.css('.student-location').text
#         student_name = student.css('.student-name').text
#         students << {name: student_name, location: student_location, profile_url: student_profile_link}
#       end
#     end
#     students
#   end
#
#   def self.scrape_profile_page(profile_url)
#     student = {}
#     profile_page = Nokogiri::HTML(open(profile_url))
#     links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
#     links.each do |link|
#       if link.include?("linkedin")
#         student[:linkedin] = link
#       elsif link.include?("github")
#         student[:github] = link
#       elsif link.include?("twitter")
#         student[:twitter] = link
#       else
#         student[:blog] = link
#       end
#     end
#   end
# end
