require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    student_doc = Nokogiri::HTML(html)
    
    students = []

    student_doc.css("div.student-card").each do |student|

      student_rel_link = student.css("a").attribute("href").value

      student = {
        :name=>student.css("a div.card-text-container h4.student-name").text,
        :location=>student.css("a div.card-text-container p.student-location").text,
        
        :profile_url=>URI.join(index_url, student_rel_link).to_s
        
      }
      

      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_details = Nokogiri::HTML(html)
    twitter = nil
    linked_in = nil
    github = nil
    blog = nil
    profile_quote = student_details.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    bio = student_details.css("div.details-container div.bio-block div.bio-content div.description-holder p").text

    student_details.css("div.vitals-container div.social-icon-container a").each do |link|
      
      link_address = link.attribute("href").value

      if link.attribute("href").value.include?("twitter.com")
        twitter = link_address
      elsif link.attribute("href").value.include?("linkedin.com")
        linked_in = link_address
      elsif link.attribute("href").value.include?("github.com")
        github = link_address
      elsif link.child.attribute("src").value.include?("rss-icon")
        blog = link_address
      else
      end
          
    end



    #social_icon = student_details.css("div.vitals-container div.social-icon-container a img").attribute("src").value

    #linked_in = if social_icon == "../assets/img/linkedin-icon.png"
    #    social_icon.parent.attribute("href").value
    #  end

    student_data = {}

      student_data[:twitter] = twitter if twitter != nil
      student_data[:linkedin] = linked_in if linked_in != nil
      student_data[:github] = github if github != nil
      student_data[:blog] = blog if blog != nil
      student_data[:profile_quote] = profile_quote if profile_quote != nil
      student_data[:bio] = bio if bio != nil

    student_data
  end

end

#Scraper.scrape_index_page("http://127.0.0.1:4000")

