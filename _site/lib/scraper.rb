require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))

    students = []

    student_site.css('div.student-card').each do |student|
      students << {
        name: student.css('div.card-text-container h4.student-name').text,
        location: student.css('div.card-text-container p.student-location').text,
        profile_url: "http://127.0.0.1:4000/" + "#{student.css('a').attribute('href').value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_site = Nokogiri::HTML(open(profile_url))

    social_web = {}

    profile_site.css('div.social-icon-container a').collect do |link|
      url = link.attribute('href').value
      social_media = ["github", "twitter", "facebook", "linkedin"]


      if url.include?('www')
        url = url[/\.(\w+)\./].delete(".")
      else
        url = url[/(\w+)\./].delete(".")
      end


      ## I wrote this hideous conditional logic because links to personal websites/blogs were being
      ## passed into the hash with the domain name as a key rather than the general :blog key
      if !social_media.include?(url)
        social_web[:blog] = link.attribute('href').value
      else
        social_web[url.to_sym] = link.attribute('href').value 
      end

    end

    social_web[:profile_quote] = profile_site.css('div.profile-quote').text
    social_web[:bio] = profile_site.css('div.bio-content p').text

    social_web
  end

end