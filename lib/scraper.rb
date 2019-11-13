require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.open(index_url)
    student_site = Nokogiri::HTML(html)
    scraped_students = []

    student_site.css("div.student-card").each do |student|
      scraped_students << {
      :name => student.css("h4").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)
    doc = Nokogiri::HTML(html)

    student_profile = {}

    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder").first.text.gsub("\n","").strip

    doc.css("div.social-icon-container a").each do |profile|
        if profile.attribute("href").value.include?("linkedin.com")
          student_profile[:linkedin] = profile.attribute("href").value
        elsif profile.attribute("href").value.include?("twitter.com")
          student_profile[:twitter] = profile.attribute("href").value
        elsif profile.attribute("href").value.include?("github.com")
          student_profile[:github] = profile.attribute("href").value
        else
          student_profile[:blog] = profile.attribute("href").value
        end
      end
    student_profile
  end

end

#student_profile[:twitter] = doc.css("div.social-icon-container a").attribute("href").value
