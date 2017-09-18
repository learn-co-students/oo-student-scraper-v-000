require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('.roster-cards-container .student-card')
    student_array = []

    student_cards.each do |student|
      student_info = Hash.new
      student_info[:name] = student.css('.student-name').text
      student_info[:location] = student.css('.student-location').text
      student_info[:profile_url] = student.css('a').attribute("href").value
      #"./fixtures/student-site/" +

      student_array << student_info
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css('.main-wrapper')
    profile_info= []

    student_profile.each do |student|
      profile = Hash.new

      profile[:twitter] = profile.css(".social-icon-container a").first.attribute("href").value
      profile[:linkedin] = profile.css(".social-icon-container a")[1].attribute("href").value
      profile[:github] = profile.css(".social-icon-container a")[2].attribute("href").value
      profile[:blog] = profile.css(".social-icon-container a")[3].attribute("href").value
      profile[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text
      profile[:bio] = profile.css(".details-container p").text

      profile_info << profile
    end

    binding.pry

    profile_info
    #twitter = profile.css(".social-icon-container a").first.attribute("href").value
    #linkedin= profile.css(".social-icon-container a")[1].attribute("href").value
    #github = profile.css(".social-icon-container a")[2].attribute("href").value
    #blog = profile.css(".social-icon-container a")[3].attribute("href").value
    #profile_quote = profile.css(".vitals-text-container .profile-quote").text
    #bio = profile.css(".details-container p").text
  end

end
