require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card")
    student_arr = []
    student_cards.collect do |student|
      student_arr << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
        }
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    socials = {}
    doc.css("div.social-icon-container a").each do |social|
        case social.attribute("href").value
        when /twitter/
          socials[:twitter] = social.attribute("href").value
        when /linkedin/
          socials[:linkedin] = social.attribute("href").value
        when /github/
          socials[:github] = social.attribute("href").value
        else
          socials[:blog] = social.attribute("href").value
        end
    end
    socials[:profile_quote] = doc.css("div.profile-quote").text.strip
    socials[:bio] =  doc.css("div.bio-content div.description-holder").text.strip
    socials
  end

end
