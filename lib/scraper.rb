require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

      doc.css('.student-card').each do | student |
        scraped_students << {
          name: student.css('.student-name').text,
          location: student.css('.student-location').text,
          profile_url: student.css('a').attr('href').value
          }
      end

      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}

    doc.css('.vitals-container .social-icon-container a').each do | social |
      if social.css('img').attr('src').value.include?("twitter")
         scraped_student[:twitter] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("linkedin")
          scraped_student[:linkedin] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("github")
          scraped_student[:github] = social.attr('href')
      elsif social.css('img').attr('src').value.include?("rss")
          scraped_student[:blog] = social.attr('href')
        end
      end

    doc.css('html').each do |details|
      scraped_student[:profile_quote] = details.css('.profile-quote').text
      scraped_student[:bio] = details.css('.bio-content.content-holder .description-holder').text.strip
    end
    scraped_student
  end

end
