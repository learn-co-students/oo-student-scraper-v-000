require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    students_array = []
    students.css('div.roster-cards-container').each do |individual_students|
      individual_students.css('.student-card a').each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        url = student.attr('href')
        students_array << {:name => name, :location => location, :profile_url => url}
      end
    end
    students_array
  end


  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student_info = {}
    bio = student_profile.css('.description-holder p').text
    profile_quote = student_profile.css('.profile-quote').text

    linkedin = ""
    github = ""
    blog = ""
    twitter = ""

    social = student_profile.css('.social-icon-container a')
        if social[3]
          blog = social[3].attr('href')
        end
      social.each do |social_site|
        if social_site.attr('href').include?("linkedin")
          linkedin = social_site.attr('href')
        elsif social_site.attr('href').include?("github")
          github = social_site.attr('href')
        elsif social_site.attr('href').include?("twitter")
          twitter = social_site.attr('href')
        end
      end
    student_info = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => profile_quote,
      :bio => bio
    }

    student_info.delete_if { |key, value| value.to_s.strip == '' }
  end

end
