require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css('div.student-card').each_with_index do |student, index|
      name = student.css('.card-text-container .student-name').text
      location = student.css('.card-text-container .student-location').text
      profile_url = student.css('a').attribute('href').value

      student_index_array << {
        :name        => name,
        :location    => location,
        :profile_url => profile_url
      }
    end

    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))

    socials = doc.css('div.social-icon-container').collect do |social|
      social.css('a').attribute('href').value
    end

    profile_quote = doc.css('div.vitals-text-container .profile-quote').text
    bio = doc.css('div.details-container .bio-block .description-holder').text

    socials.each do |social|
      # parse social_sym from social_val
  		# 	add social_sym to scraped_student hash
  		# 	assign social_sym = social_val
      puts "#{social}"
    end

    scraped_student[:profile_quote] = profile_quote.strip
    scraped_student[:bio]           = bio.strip

    scraped_student
  end

end
