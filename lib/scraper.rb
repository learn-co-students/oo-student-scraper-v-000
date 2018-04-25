require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    scraped_students = []
    
    doc.search(".student-card").each do |student|
      info = { 
        name: student.search(".student-name").text, 
        location: student.search(".student-location").text,
        profile_url: 
          student.search("a").map do |link|
            link.attribute('href').to_s
          end.uniq.sort.delete_if {|href| href.empty?}.join
      }
      scraped_students << info
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    scraped_student = {}
    
    scraped_student[:bio] = profile.search(".bio-block .description-holder p").text

    scraped_student[:profile_quote] = profile.search(".profile-quote").text

    profile.search(".social-icon-container a").each do |link|
      if link['href'].include? "github.com"
        scraped_student[:github] = link['href']
      elsif link['href'].include? "linkedin.com"
        scraped_student[:linkedin] = link['href']
      elsif link['href'].include? "twitter.com"
        scraped_student[:twitter] = link['href']
      else 
        scraped_student[:blog] = link['href']
      end
    end

    scraped_student
  end

end

