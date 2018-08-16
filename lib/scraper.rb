require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
  #  html = (open("http://165.227.31.208:57678/fixtures/student-site/"))
    html = (open(index_url))
    doc = Nokogiri::HTML(html)
    student_profiles = []
    student_info = doc.css(".student-card")
      student_info.collect do |profile|
          student_profile = {}
          student_profile[:name] =  profile.css('.card-text-container .student-name').text
          student_profile[:location] = profile.css('.card-text-container .student-location').text
          student_profile[:profile_url] = profile.css('a').first.attribute('href').value

          student_profiles << student_profile
        end
        student_profiles
      end

  def self.scrape_profile_page(profile_url)
    html = (open(profile_url))
    doc = Nokogiri::HTML(html)
    student_data = {}

    doc.css('.main-wrapper').each do |profile|
      student_data[:profile_quote] = profile.css(".vitals-container .vitals-text-container .profile-quote").text
      student_data[:bio] = profile.css(".details-container .description-holder p").text
      profile.css('.vitals-container .social-icon-container a').each do |link|
      if link.attributes['href'].value.include?("twitter")
            student_data[:twitter] = link.attributes['href'].value
      elsif link.attributes['href'].value.include?("linkedin")
            student_data[:linkedin] = link.attributes['href'].value
      elsif  link.attributes['href'].value.include?("github")
           student_data[:github] = link.attributes['href'].value
      else link.attributes['href'].value.include?(doc.css('.vitals-text-container .profile-name').text.downcase.split.join("-"))
          student_data[:blog] = link.attributes['href'].value
        end
      end
    end
    student_data
  end

end
