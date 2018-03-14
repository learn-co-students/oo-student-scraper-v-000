require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    student_list = Nokogiri::HTML(open(index_url))
    student_list.css('div.student-card').each {|student|
      students << {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => "./fixtures/student-site/" + student.css('a').first.attr('href')
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_data = {}

    student_page = Nokogiri::HTML(open(profile_url))
    social_hrefs = student_page.css('div.social-icon-container a').map{
      |link| link.attribute('href').to_s
    }

    twitter = social_hrefs.detect{|i| i.include?('twitter')}
    profile_data[:twitter] = twitter if twitter

    linked = social_hrefs.detect{|i| i.include?('linkedin')}
    profile_data[:linkedin] = linked if linked

    github = social_hrefs.detect{|i| i.include?('github')}
    profile_data[:github] = github if github

    blog = social_hrefs.detect{|i| /(\.com\/\z)|(\.com\z)/ === i}
    profile_data[:blog] = blog if blog

    profile_data[:profile_quote] = student_page.css('div.profile-quote').text

    profile_data[:bio] = student_page.css('div.bio-content.content-holder div.description-holder p').text

    profile_data
  end

end
