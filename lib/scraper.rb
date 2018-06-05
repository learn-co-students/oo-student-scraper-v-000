require 'open-uri'
require 'pry'
# require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(File.read(index_url))
    students = []

    flatiron.css('div.student-card').each { |student|
      person = {
        name: student.css('h4.student-name').text,
        location: student.css('p.student-location').text,
        profile_url: student.css('a').attribute('href').value
      }
      students.push(person)
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
    profile_data = {}

    profile.css('a').each { |link|
      url = link.attribute('href').value

      if url.include? 'twitter'
        profile_data[:twitter] = url
      elsif url.include? 'linkedin'
        profile_data[:linkedin] = url
      elsif url.include? 'github'
        profile_data[:github] = url
      elsif !url.include? '../'
        profile_data[:blog] = url
      end
    }

    quote = profile.css('div.profile-quote').text
    if quote != ''
      profile_data[:profile_quote] = quote
    end

    bio = profile.css('div.description-holder')[0].text.strip
    if bio != ''
      profile_data[:bio] = bio
    end

    profile_data
  end
end
