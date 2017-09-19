require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('div.student-card').each do |student_array|
      student = {}
      student[:name] = student_array.css('h4.student-name').text
      student[:location] = student_array.css('p.student-location').text
      student[:profile_url] = student_array.css('a')[0]['href']
      student_index_array.push(student)
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile_hash = {}
    doc.css('div.social-icon-container a').each do |student_social_urls|
      if student_social_urls.values[0].include?("twitter")
        student_profile_hash[:twitter] = student_social_urls.values[0]
      elsif student_social_urls.values[0].include?("github")
        student_profile_hash[:github] = student_social_urls.values[0]
      elsif student_social_urls.values[0].include?("linkedin")
        student_profile_hash[:linkedin] = student_social_urls.values[0]
      else
        student_profile_hash[:blog] = student_social_urls.values[0]
      end
    end
    doc.css('div.profile').each do |student_profile|
      student_profile_hash[:profile_quote] = student_profile.css('div.profile-quote').text.strip
      student_profile_hash[:bio] = student_profile.css('div.bio-content div.description-holder').text.strip
    end
    student_profile_hash
  end
end

