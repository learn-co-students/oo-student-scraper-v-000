require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_page = Nokogiri::HTML(open (index_url))

    scraped_students = []

      learn_page.css("div.roster-cards-container").each do |card|
        card.css("div.student-card a").each do |student|
          scraped_students << {
            :name => student.css('.student-name').text,
            :location => student.css('.student-location').text,
            :profile_url => "http://127.0.0.1:4000/#{student.attr('href')}",
            }
        end
      end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open (profile_url))

    scraped_profile = { :profile_quote => student_page.css("div.profile-quote").text,
    :bio => student_page.css("div.description-holder p").text}

    student_page.css("div.social-icon-container a").each do |social_link|
      url = social_link.attribute("href").value

      if url.include?("twitter")
        scraped_profile[:twitter] = url

      elsif url.include?("linkedin")
        scraped_profile[:linkedin] = url
        
      elsif url.include?("github")
        scraped_profile[:github] = url
      
      else url.include?("blog")
        scraped_profile[:blog] = url
      end
    end
    scraped_profile
  end

end

