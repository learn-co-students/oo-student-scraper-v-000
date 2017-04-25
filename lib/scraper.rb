require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)

    scraped_web_page = Nokogiri::HTML(open(index_url))

    students = scraped_web_page.css('div.student-card')

     scraped_students = []

     students.each {|student|  scraped_students << {:name => student.css('a h4.student-name').text, :location => student.css('a p.student-location').text, :profile_url => "./fixtures/student-site/" + student.css('a[href]').attribute('href').value}}
     scraped_students
  end

  def self.scrape_profile_page(profile_url)

    student_profile = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}

    #get social media links array
    social_links = student_profile.css('div.social-icon-container a')

    #iterate over links and put them into scraped_profile
    social_links.each do |link|
      if link.attribute('href').value.include?('twitter')
        scraped_profile[:twitter] = link.attribute('href').value
      elsif link.attribute('href').value.include?('linked')
        scraped_profile[:linkedin] = link.attribute('href').value
      elsif link.attribute('href').value.include?('github')
        scraped_profile[:github] = link.attribute('href').value
      else
        scraped_profile[:blog] = link.attribute('href').value
      end
    end

    #add profile quote to scraped_profile hash
    scraped_profile[:profile_quote] = student_profile.css('div.profile-quote').text

    #add bio to scraped_profile hah
    scraped_profile[:bio] = student_profile.css('div.bio-content div.description-holder p').text

    scraped_profile
  end

end
