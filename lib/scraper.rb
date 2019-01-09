require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    studentDoc = Nokogiri::HTML(html)
    students = []
    studentDoc.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
        }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profileDoc = Nokogiri::HTML(html)
    profile = {}
    profile[:profile_quote] = profileDoc.css('.profile-quote').text
    profile[:bio] = profileDoc.css('.description-holder p').text
    profileDoc.css('.social-icon-container a').each do |link|
      href = link.attribute('href').value
      case
      when href.include?('twitter')
        profile[:twitter] = href
      when href.include?('linkedin')
        profile[:linkedin] = href
      when href.include?('github')
        profile[:github] = href
      else
        profile[:blog] = href
      end
    end
    profile
  end

end
