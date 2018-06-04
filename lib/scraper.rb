require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  #student: .student-card
  #student name: .student-card .card-text-container .student-name
  #student name: .student-card .card-text-container .student-location
  #student profile url .student-card a (get attrinbute, href)


  def self.scrape_index_page(index_url)
    scraped_stus = []
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    student_data=doc.css(".student-card")
    #binding.pry
    student_data.each do |student|
      name = student.css('.card-text-container .student-name').text
      location=student.css('.card-text-container .student-location').text
      profile_url=student.css('a').first.attribute("href").text
      #binding.pry
      stu_hash={name: name, location:location, profile_url:profile_url}
      scraped_stus<<stu_hash
      #binding.pry
    end
    scraped_stus
  end

  def self.scrape_profile_page(profile_url)
    html=open(profile_url)
    doc=Nokogiri::HTML(html)
    stu_hash={}

    #handling vitals scraping
    quote=doc.css(".profile-quote").text
    bio=doc.css(".description-holder p").text
    stu_hash[:bio]=bio
    stu_hash[:profile_quote]=quote


    #handling social links
    socials=doc.css(".social-icon-container a")
    socials.each do |social|
      soc_link=social.attribute("href").text

      if soc_link.include?('linkedin')==true
        stu_hash[:linkedin]=soc_link
      elsif soc_link.include?('twitter')==true
        stu_hash[:twitter]=soc_link
      elsif soc_link.include?('github')==true
        stu_hash[:github]=soc_link
      else
        stu_hash[:blog]=soc_link
      end
    end
    stu_hash
  end

end
