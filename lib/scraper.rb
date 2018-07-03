require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    index_page.css("div.student-card").each_with_index {|student_card,i|
      student_card.css("h4.student-name").each {|student_name| students << {name: student_name.text}}
      student_card.css("p.student-location").each {|student_location| students[i][:location] = student_location.text}
      student_card.css("a").each {|student_url| students[i][:profile_url] = student_url['href']}
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = profile_page.css("div.vitals-container")
    student.css("div.vitals-text-container div.profile-quote").each {|profile_quote| profile[:profile_quote] = profile_quote.text}
    student.css("div.social-icon-container a").each {|link|
      if link['href'].include?('twitter')
        profile[:twitter] = link['href']
      elsif link['href'].include?('linkedin')
        profile[:linkedin] = link['href']
      elsif link['href'].include?('github')
        profile[:github] = link['href']
      else
        profile[:blog] = link['href']
      end
    }
    student = profile_page.css("div.details-container")
    student.css("div.description-holder p").each {|bio| profile[:bio] = bio.text}
    profile
  end

end
