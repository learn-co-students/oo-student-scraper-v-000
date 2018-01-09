require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  scraped_students = []
  doc.css("div.roster-cards-container").each do |student_value|
  student = {}
    student_value.css("div.student-card").each do |student_attr|
      student = {
      :name => student_attr.search("h4.student-name").text,
      :location => student_attr.search("p.student-location").text,
      :profile_url => student_attr.search("a").attribute("href").value
      }
      scraped_students<<student
    end
  end
  scraped_students
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css("div.vitals-container").each do |social_content|
        social_content.css("div.social-icon-container a").each do |social|
              social_link = social.attribute("href").value
              if social_link.include?('twitter')
                student[:twitter] = social_link
              elsif social_link.include?('linkedin')
                student[:linkedin] = social_link
              elsif social_link.include?('github')
                student[:github] = social_link
              else
                student[:blog] = social_link
            end
          end
        end
    doc.css("div.vitals-text-container").each do |content|
      student[:profile_quote] = content.css("div.profile-quote").text
    end
      student[:bio] = doc.css("div.details-container").css('p').text
    student
    end
  end
