require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each do |student|
      scraped_students << {:name => student.css("h4.student-name").first.text,
      :location => student.css("p.student-location").first.text,
      :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    scraped_student = {
    :profile_quote => doc.css("div.profile-quote").text,
    :bio => doc.css("div.bio-content.content-holder p").text}

    doc.css("div.social-icon-container a").each do |social_icon|
      unless social_icon.children.attribute("src").nil?
        if social_icon.children.attribute("src").value =~ /rss/
          scraped_student[:blog] = social_icon.attribute("href").value
        end
      end

      ['twitter', 'linkedin', 'github'].each do |social_string|
        social_url = social_icon.attribute("href").value
        if social_url =~ /#{social_string}/
          scraped_student[social_string.to_sym] = social_url
        end
      end
    end
  scraped_student
  end # end of self.scrape_profile_page

end # end of class

Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")
