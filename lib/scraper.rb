require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    student_array = []

    doc.css(".student-card").each do |student|

    student_array << {
      name: student.css(".student-name").text,

      location: student.css(".student-location").text,

      profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}"}
    end

    student_array

  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    student_info = {}

    student_info[:profile_quote] = doc.css(".profile-quote").text

    student_info[:bio] = doc.css(".bio-content .description-holder p").text


    doc.css("div.social-icon-container a").each do |social|

    	soc_value = social.attribute("href").value

    	if soc_value.include?("twitter")
    		student_info[:twitter] = soc_value

    	elsif soc_value.include?("linkedin")
    		student_info[:linkedin] = soc_value

    	elsif soc_value.include?("github")
    		student_info[:github] = soc_value

    	else
    		student_info[:blog] = soc_value
    	end
    end

    student_info

   end
end
