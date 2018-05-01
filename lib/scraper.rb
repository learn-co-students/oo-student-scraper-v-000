require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #retreive student page
    html = File.read(index_url)
    #access HTML of stuent page
    students = Nokogiri::HTML(html)

    #initialize student hash as an empty hash
    students_array = []

    students.css('.student-card').each do |student|
      student_hash = {}

      student_hash[:name] = student.css('h4').text
      student_hash[:location] = student.css('p').text

      student_hash[:profile_url] = student.css('a').first['href']
      students_array << student_hash
    end
    students_array

  end

  def self.scrape_profile_page(profile_url)
    #retreive student page
    html = File.read(profile_url)
    #access HTML of stuent page
    infos = Nokogiri::HTML(html)

    #initializes student_profile as a has
    scraped_student = {}

    #scrape the bio and profile quote from vitals-container
    scraped_student[:bio] = infos.css('.details-container').css('p').text
    scraped_student[:profile_quote] = infos.css('.vitals-container').css('.profile-quote').text

    #assign all the social media attributes
    infos.css('.social-icon-container').css('a').each do |icon|
      #return the url
      url = icon['href']

      #return just the host for example "http://twitter.com" -> 'twitter.com'
      host = URI.parse(url).host

      #gets the domain name from the host
      host.start_with?('www.') ? domain = host.split('.')[1] : domain = host.split('.')[0]

      #checks if domain is in known social media types
      known_domains = ['twitter', 'github', 'linkedin']

      if known_domains.include?(domain)
        #assigns the attribute of the domain to the url
        scraped_student[domain.to_sym] = url
      else
        #assigns blog attribute
        scraped_student[:blog] = url
      end


    end


    scraped_student
  end

end
