require 'open-uri'
require 'pry'
require 'nokogiri'

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
    
    # can't handle nil attributes
    
    twitter = profile.css('a')[1].attribute('href').value if profile.css('a')[1] != nil
    linkedin = profile.css('a')[2].attribute('href').value if profile.css('a')[2] != nil
    github = profile.css('a')[3].attribute('href').value if profile.css('a')[3] != nil
    blog = profile.css('a')[4].attribute('href').value if profile.css('a')[4] != nil
    profile_quote = profile.css('div.profile-quote').text
    bio = profile.css('div.description-holder')[0].text.strip

    profile_data = {}
    
    if twitter != nil
      profile_data[:twitter] = twitter
    end
    
    if linkedin != nil
      profile_data[:linkedin] = linkedin
    end
    
    if github != nil
      profile_data[:github] = github
    end
    
    if blog != nil
      profile_data[:blog] = blog
    end
    
    if profile_quote != nil
      profile_data[:profile_quote] = profile_quote
    end
    
    if bio != nil
      profile_data[:bio] = bio
    end

    profile_data
  end

end

