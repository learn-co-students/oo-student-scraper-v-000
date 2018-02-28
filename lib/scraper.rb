require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
    scraped_student = []
    doc.css("div.student-card").collect {|student|
      student_hash = {
        :name => student.css("a h4.student-name").text,
        :location => student.css("a p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
        scraped_student << student_hash
    }
    scraped_student
  end

  def self.scrape_profile_page(profile_url)
       student_profile = Nokogiri::HTML(File.read(profile_url))
       scraped_student = {}

       links = student_profile.css("div.social-icon-container a").collect {|ele| ele.attribute("href").value}

       links.each do |link|
         if link.include?("twitter")
           scraped_student[:twitter] = link
         elsif link.include?("linkedin")
           scraped_student[:linkedin] = link
         elsif link.include?("github")
           scraped_student[:github] = link
         else
           scraped_student[:blog] = link
         end
       end
       scraped_student[:profile_quote] = student_profile.css("div.profile-quote").text
       scraped_student[:bio] = student_profile.css("div.details-container div.bio-block.details-block div.bio-content.content-holder p").text
       scraped_student
     end

   end
