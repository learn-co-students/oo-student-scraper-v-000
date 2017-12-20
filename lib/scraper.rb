require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    card = []
    student_card = doc.css("div.student-card").each do |student|
      card << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    card
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_details = {}
    page.css("div.social-icon-container a").each do |d|
        if d.attribute("href").value.include?('twitter')
          student_details[:twitter] = d.attribute("href").value

        elsif d.attribute("href").value.include?("linkedin")
          student_details[:linkedin] = d.attribute("href").value

        elsif d.attribute("href").value.include?("github")
        student_details[:github] = d.attribute("href").value

        elsif d.attribute("href").value.include?("http")
          student_details[:blog] = d.attribute("href").value
        end
     end
     student_details[:profile_quote] = page.css("div.profile-quote").text
     student_details[:bio] = page.css("div.description-holder p").text
     student_details
  end


  # def self.scrape_profile_page(profile_slug)
  #   student = {}
  #   profile_page = Nokogiri::HTML(open(profile_slug))
  #   links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
  #   links.each do |link|
  #     if link.include?("linkedin")
  #       student[:linkedin] = link
  #     elsif link.include?("github")
  #       student[:github] = link
  #     elsif link.include?("twitter")
  #       student[:twitter] = link
  #     else
  #       student[:blog] = link
  #     end
  #   end
  #   student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  #   student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
  #
  #   student
  # end
end
