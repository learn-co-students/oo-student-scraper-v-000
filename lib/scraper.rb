# require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)    
    index_page = Nokogiri::HTML(File.read(index_url))

    index_page.css('.student-card').collect do |student|
    	{
	    	name: student.css('h4.student-name').text,
	    	location: student.css('p.student-location').text,
	    	profile_url: student.css('a').attribute('href').value
    	}
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(File.read(profile_url))
    social_links = profile_page.css('div.social-icon-container a').collect { |link| link.attribute('href').value }

    student_profile = {}

    social_links.each do |link|
    	if link.include?('twitter')
    		student_profile[:twitter] = link
    	elsif link.include?('linkedin')
    		student_profile[:linkedin] = link
    	elsif link.include?('github')
    		student_profile[:github] = link
    	else
    		student_profile[:blog] = link
    	end
    end

  	student_profile[:profile_quote] = profile_page.css('div.profile-quote').text
  	student_profile[:bio] = profile_page.css('div.description-holder p').text
  	student_profile
  end

end