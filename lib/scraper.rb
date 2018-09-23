require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html(index_url).css(".student-card").map do |student|
      {
        name: student.css('.student-name').text,
        location: student.css('.student-location').text,
        profile_url: student.css('a').attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student_profile = html(profile_url).css(".profile")

    student_profile_hash = {}
    student_profile_hash =
    {
      profile_quote: student_profile.css(".profile-quote").text,
      bio: student_profile.css(".bio-content p").text
    }
    student_profile.css(".social-icon-container a").each do | social |
      social_link = social.attribute('href').value
      
      if /twitter/.match(social_link)
        student_profile_hash[:twitter] = social_link
      elsif /linkedin/.match(social_link)
        student_profile_hash[:linkedin] = social_link
      elsif /github/.match(social_link)
        student_profile_hash[:github] = social_link
      else
        student_profile_hash[:blog] = social_link
      end
    end

    student_profile_hash
  end

  def self.html(url)
    Nokogiri::HTML(open(url))
  end
end
