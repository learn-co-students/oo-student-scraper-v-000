require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    names = self.get_student_names(index)
    locations = self.get_student_locations(index)
    urls = self.get_student_profile_urls(index)
    student_count = names.size
    counter = 0
    students = []

    until counter == (student_count - 1) do
      student = {
        :name => names[counter],
        :location => locations[counter],
        :profile_url => urls[counter]
      }
      students << student
      counter += 1
    end
    students
  end

#helper methods for self.scrape_index_page

  def self.get_student_names(index)
    names = []
    student_names = index.css('div.student-card h4.student-name')
    student_names.each {|student| names << student.text}
    names
  end

  def self.get_student_locations(index)
    locations = []
    student_locations = index.css('div.student-card p.student-location')
    student_locations.each {|student| locations << student.text}
    locations
  end

  def self.get_student_profile_urls(index)
    profiles = []
    student_profile_urls = index.css('div.student-card a')
    student_profile_urls.each {|student| profiles << "./fixtures/student-site/" + student.attribute('href').value}
    profiles
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    twitter = self.get_social_media(profile).detect {|url| url.match(/\S*twitter.com\S*/)}
    linkedin = self.get_social_media(profile).detect {|url| url.match(/\S*linkedin.com\S*/)}
    github = self.get_social_media(profile).detect {|url| url.match(/\S*github.com\S*/)}
    blog = self.get_social_media(profile).detect {|url| url != twitter && url != linkedin && url != github}
    profile_quote = self.get_profile_quote(profile)
    bio = self.get_bio(profile)

    student = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => profile_quote,
      :bio => bio
    }
    
    self.clean_hash(student)
  end

  #helper methods for profile scraper

  def self.get_social_media(profile)
    social_links = []
    social_media = profile.css('div.social-icon-container a')
    social_media.each {|link| social_links << link.attribute('href').value}
    social_links
  end

  def self.get_profile_quote(profile)
    profile_quote = profile.css('div.vitals-text-container div.profile-quote').text
  end

  def self.get_bio(profile)
    bio = profile.css('div.bio-content.content-holder div.description-holder p').text
  end

  def self.clean_hash(student)
    student.delete_if {|key, value| value == nil}
  end

end
