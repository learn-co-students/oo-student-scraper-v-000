require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    students_scrape = doc.css('div.student-card')

    students_scrape.collect do |student|
      {
          :name => student.css('h4').text,
          :location => student.css('p').text,
          :profile_url => student.css('a').attribute('href').value
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)

    scraped_student = {}

    collected_socials = []
    doc.css('div.social-icon-container a').each {|url|
    collected_socials << url
  }

    collected_socials.each do |path|
      if path.attribute('href').value.include? "twitter"
        scraped_student[:twitter] = path.attribute('href').value
      elsif path.attribute('href').value.include? "linkedin"
        scraped_student[:linkedin] = path.attribute('href').value
      elsif path.attribute('href').value.include? "github"
        scraped_student[:github] = path.attribute('href').value
      else
        scraped_student[:blog] = path.attribute('href').value
      end
    end
    scraped_student[:profile_quote] = doc.css('div.profile-quote').text
    scraped_student[:bio] = doc.css('div.description-holder p').text
    scraped_student
  end
end
