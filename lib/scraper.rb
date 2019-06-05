require 'open-uri'
require 'pry'
class Scraper

  def self.scrape_index_page(index_url)
    html = (open(index_url))
    parsed_content = Nokogiri::HTML(html)
    student_info = parsed_content.css(".student-card")
     scraped_students = []
    student_info.each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
        }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = (open(profile_url))
    parsed_content = Nokogiri::HTML(html)
    scraped_profile = {}
    scraped_profile[:profile_quote] = parsed_content.css('.profile-quote').text
    scraped_profile[:bio] = parsed_content.css('.description-holder p').text
    parsed_content.css('.social-icon-container a').each do |link|
      href = link.attribute('href').value
      if href.include?('twitter')
        scraped_profile[:twitter] = href
      elsif href.include?('linkedin')
        scraped_profile[:linkedin] = href
      elsif href.include?('github')
        scraped_profile[:github] = href
      elsif
        scraped_profile[:blog] = href
      end
    end
    scraped_profile
  end
end
