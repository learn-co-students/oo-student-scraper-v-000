require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array
    # of hashes in which each hash represents one student
    # I need to return an array to iterate over to grab the information I want.

    doc = Nokogiri::HTML(open(index_url))
    array_containing_hashes_with_student_information = []
    doc.css('.student-card').each do |post|
      student_scraper_hash = {}
      student_scraper_hash[:name] = post.css('.student-name').first.text # gets the student name
      student_scraper_hash[:location] = post.css('.student-location').first.text # gets the student's location
      student_scraper_hash[:profile_url] = post.css('a').first["href"] # gets the profile url
      array_containing_hashes_with_student_information << student_scraper_hash # pushes the hash into the array we're returning
      # binding.pry
    end
    array_containing_hashes_with_student_information # return the array
  end

  def self.scrape_profile_page(profile_url)
    # is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
    # can handle profile pages without all of the social links
    # The method first finds the key to hold the profile pages's links by taking the web address, turning it into an array,
    # pulls out the string containing the web address, turns that string into an array, takes out the address name, and makes
    # that the key. Except for the blog, if it's the blog, the key doesn't = twitter or github or linkedin.
    # It iterates over the website two times to grab the web address. It returns the student hash array that contains the
    # key and values created from the each iterators.
      doc = Nokogiri::HTML(open(profile_url))
      student_hash = {}
      doc.css('.vitals-container').each do |post|
        # binding.pry
        post.css('.social-icon-container a').each do |element|
          if element['href'].split(".").size == 2 && element['href'].split(".")[0].split("//")[1] != "twitter" && element['href'].split(".")[0].split("//")[1] != "github" && element['href'].split(".")[0].split("//")[1] != "linkedin"
            key = :blog
          elsif element['href'].split(".").size == 2
            key = element['href'].split(".")[0].split("//")[1].to_sym
          elsif element['href'].split(".").size == 3
            key = element['href'].split(".")[1].to_sym
          end
          student_hash[key] = element['href']
          # binding.pry
        end
        student_hash[:profile_quote] = post.css('.vitals-text-container').first.css('.profile-quote').text
        student_hash[:bio] = doc.css('.description-holder').first.css('p').text
        # binding.pry
      end
      # binding.pry
      student_hash
  end

end
