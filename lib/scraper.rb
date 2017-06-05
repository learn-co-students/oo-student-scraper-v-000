require 'open-uri'
require 'pry'

class Scraper

     def self.scrape_index_page(index_url)

        doc = Nokogiri::HTML(open(index_url))
        student_array =[]
        doc.css(".student-card").each do |card|
          student_hash = {}
          student_hash =  {
          :name => card.css(".student-name").text,
          :location => card.css(".student-location").text,
          :profile_url => card.css("a").attr('href').text
          }
          student_array << student_hash
        end
        student_array
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

end
