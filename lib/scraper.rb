require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url) #set var to pass in to learn_students
    learn_students = Nokogiri::HTML(html) #Noko-rize it
    scraped_students = []

    learn_students.css('div.student-card').each do |student| #"div.roster-cards-container" not specific enough.
      scraped_students << { #add the following symbols to scraped_students array as hashes
      #binding.pry
      :name => student.css('h4.student-name').text,
      :location => student.css('p.student-location').text,  #or longer: 'a div.card-text-container p.student-location'
      :profile_url => "./fixtures/student-site/" + student.css('a').attribute("href").value
    }
    #binding.pry
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    scraped_students = {}

    profile.css('div.social-icon-container a').each do |student|  #gettin all the a => hrefs from the social icon container.
      a_hrefs = student.attribute("href") #shortening the href attribute into a variable
      link = student.attribute("href").value

      a_hrefs.value.include?("twitter") ? scraped_students[:twitter] = link : []
      a_hrefs.value.include?("linkedin") ? scraped_students[:linkedin] = link : []
      a_hrefs.value.include?("github") ? scraped_students[:github] = link : []
      html.include?("rss") ? scraped_students[:blog] = link : [] #grabbing from html. not sure if rss would be in all of them, but...
    end
     scraped_students[:profile_quote] = profile.css('div.profile-quote').text #separately adding non-social media stuff, have specific div.classes.
     scraped_students[:bio] = profile.css('div.description-holder p').text
     return scraped_students
  end

end

  #student name: a div.card-text-container h4.student-name').text
  #student location: a div.card-text-container p.student-location').text #or much less:  a p.student-location').text
  # html.include?("github") ? scraped_students[:github] = student.css('a:nth-child(3)').attribute("href").value : [] #so much for nth child
  # html.include?("rss") ? scraped_students[:blog] = student.css('a:nth-child(4)').attribute("href").value : []
