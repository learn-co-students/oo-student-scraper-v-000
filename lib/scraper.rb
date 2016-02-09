require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))
  	students = []

  	doc.css('div.student-card').each do |card|
  		student = {
  			:name => card.css('h4.student-name').text, :location => card.css('p.student-location').text, :profile_url => "http://127.0.0.1:4000/#{card.css('a').attribute('href').value}"
  		}
  		students << student 
  	end
    students
  end

  def self.scrape_profile_page(profile_url)
  	doc = Nokogiri::HTML(open(profile_url))
  	
  	info = {
  		:profile_quote => doc.css('div.profile-quote').text,
  		:bio => doc.css('div.description-holder p').text
  	}

  	doc.css("div.social-icon-container a").each do |a|
  		#link = attribute('src').value
  		if a.css('img').attribute('src').value.include?('linkedin')
  			info[:linkedin] = a.attribute('href').value
  		elsif a.css('img').attribute('src').value.include?('github')
  			info[:github] = a.attribute('href').value
  		elsif a.css('img').attribute('src').value.include?('twitter')
  			info[:twitter] = a.attribute('href').value
  		elsif a.css('img').attribute('src').value.include?('rss')
  			info[:blog] = a.attribute('href').value
  		end
  		
    end
    info
  end

end

