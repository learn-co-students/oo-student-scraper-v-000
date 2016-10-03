require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    student_hash = {}

    html = open(index_url)

    doc = Nokogiri::HTML(html)

      doc.css(".student-card").each do |student|
        student_hash = {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => "./fixtures/student-site/" + student.children[1].attribute("href").value
        }

        scraped_students << student_hash
      end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    student_profile = {}

    html = open(profile_url)

    profile_doc = Nokogiri::HTML(html)

    #collects any social media links present from student profile
    social_media = profile_doc.css(".vitals-container .social-icon-container").children.css("a").collect {|link| link.attribute("href").value}

    social_media.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else link.include?("blog")
        student_profile[:blog] = link
      end
      #student_profile
    end

    student_profile[:profile_quote] = profile_doc.css(".profile-quote").text
    student_profile[:bio] = profile_doc.css(".bio-content.content-holder p").text

    student_profile

  end

end
