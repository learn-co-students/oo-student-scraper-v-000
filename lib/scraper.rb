require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_class = Nokogiri::HTML(html)
    students = []
    student_class.css('.student-card').each do |card|
      students << {
        :name => card.css('.student-name').text,
        :location => card.css('.student-location').text,
        :profile_url => './fixtures/student-site/' << card.css('a')[0]['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_profiles = Nokogiri::HTML(html)
    profile = student_profiles.css('.vitals-container')
    description = student_profiles.css('.details-container')
    profile_details = {}
    profile.css('.social-icon-container a[href]').each do |link|
      if link['href'].include?("twitter")
        profile_details[:twitter] = link['href']
      elsif link['href'].include?("linkedin")
        profile_details[:linkedin] = link['href']
      elsif link['href'].include?("github")
        profile_details[:github] = link['href']
      elsif link['href'].include?("youtube")
        profile_details[:youtube] = link['href']
      else
        profile_details[:blog] = link['href']
      end
    end
    profile_details[:profile_quote] = profile.css('.profile-quote').text.strip
    profile_details[:bio] = description.css('.description-holder p').text.strip

    profile_details
  end

end
