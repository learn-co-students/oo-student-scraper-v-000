require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css("div.student-card").each do |card|

      s = {
      :name => card.css('h4.student-name').text,
      :location => card.css('p.student-location').text,
      :profile_url => card.css('a').attribute('href').value
      }

      students << s
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

      profiles = {}

        profile_info = doc.css(".vitals-container .social-icon-container a").collect do |socials|
          socials.attribute("href").value
        end

          profile_info.each do |s|
            if s.include?("twitter")
              profiles[:twitter] = s
            elsif s.include?("linkedin")
              profiles[:linkedin] = s
            elsif s.include?("github")
              profiles[:github] = s
            else s.include?("blog")
              profiles[:blog] = s
            end
          end

      profiles[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
      profiles[:bio] = doc.css(".description-holder p").text

      profiles
  end

end
