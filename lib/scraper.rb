require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")
    student_card.each do |student|
      students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
        }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    social_media = doc.css(".social-icon-container a")
    social_media.each do |social_media_site|
      link = social_media_site.attribute('href').value
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text
    # blog = doc.css("")
    # profile = doc.css("")
    # bio = doc.css("")
    # details = doc.css("")
    # social_media_hash = {}
    #   twitter: social_media[0].attribute('href').value,
    #   linkedin: social_media[1].attribute('href').value,
    #   github: social_media[2].attribute('href').value,
    #   blog: ,
    #   profile_quote: ,
    #   bio:
    # }
    profile
  end

end
