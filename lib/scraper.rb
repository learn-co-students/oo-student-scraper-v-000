require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

        def self.scrape_index_page(index_url)
          html = open(index_url)
          doc = Nokogiri::HTML(html)
          students = []
          doc.css("div.roster-cards-container").each do |all_students|
            all_students.css(".student-card").each do |student|
              name = student.css('.student-name').text
              location = student.css(".student-location").text
              profile_url = student.css("a").attr("href").text
              # literal hash constructor:
              students << {name: name, location: location, profile_url: profile_url}
            end
           end
           students
         end



  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    name = doc.css(".vitals-text-container h1").text
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css("div.description-holder p").text

    scraped_student = {profile_quote: profile_quote, bio: bio}

    doc.css("div.social-icon-container a").each do |container_element|
      social_media_links = []
      if container_element.attr("href").include?("twitter")
        scraped_student[:twitter] = container_element.attr("href")
        social_media_links << scraped_student[:twitter]
      end
        if container_element.attr("href").include?("github")
          scraped_student[:github] = container_element.attr("href")
          social_media_links << container_element.attr("href")
        end
          if container_element.attr("href").include?("linkedin")
            scraped_student[:linkedin] = container_element.attr("href")
            social_media_links << container_element.attr("href")
          end
            unless social_media_links.include?(container_element.attr("href"))
              scraped_student[:blog] = container_element.attr("href")
            end
      end
      scraped_student
  end

end
