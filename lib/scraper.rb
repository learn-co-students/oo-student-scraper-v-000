require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    people = []
    #binding.pry
    #doc.css(".student-name").first.text
    #doc.css(".student-location").first.text
    #doc.css("div.student-card a").attribute("href").value
    doc.css(".student-card").each do |person|

      people << {
          :name => person.css(".student-name").text,
          :location => person.css(".student-location").text,
          :profile_url => person.css("a").attribute("href").value
        }
    end
    people

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_bio = []
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    temp_string =""
    #binding.pry
    #doc.css(".vitals-text-container .profile-name").text
    #doc.css(".social-icon-container a img").attribute("src").value
    doc.css(".social-icon-container a").each do |person|
      temp_string = person.values
      if temp_string.to_s.include?("twitter")
        twitter = temp_string
      elsif temp_string.to_s.include?("linkedin")
        linkedin = temp_string
      elsif temp_string.to_s.include?("github")
        github = temp_string
      else
        blog = temp_string
      end
    end

    person_info = {}
    profile_quote = doc.css(".vitals-text-container div").text.to_s
    bio = doc.css(".description-holder p").first.text


    if twitter != ""
      person_info[:twitter] = twitter.join
    end
    if linkedin != ""
      person_info[:linkedin] = linkedin.join
    end
    if github != ""
      person_info[:github] = github.join
    end
    if blog != ""
      person_info[:blog] = blog.join
    end
    if profile_quote != ""
      person_info[:profile_quote] = profile_quote
    end
    if bio != ""
      person_info[:bio] = bio
    end

    person_info
  end
end
