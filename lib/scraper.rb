require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  #container: project.css("div.student-card").text
  #name: project.css("div.card-text-container h4.student-name").text
  #location: project.css("div.card-text-container p.student-location").text
  #profile_url: project.css("div.student-card a href").text

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    profiles = Nokogiri::HTML(html)

    student_profiles = []

      profiles.css(".student-card").collect do |profile|
        student_profiles << {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").text
        }
      end
      student_profiles
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profiles = Nokogiri::HTML(html)

      #binding.pry
      single_profile = Hash.new.tap do |h|
        profiles.css(".social-icon-container a").each do |link|
          icon = link.css("img").attr("src").value
            case icon
              when /github/
                h[:github] = link.attr("href")
              when /twitter/
                h[:twitter] = link.attr("href")
              when /linkedin/
                h[:linkedin] = link.attr("href")
              when /rss/
                h[:blog] = link.attr("href")
            end
          end
          h[:profile_quote] = profiles.css(".profile-quote").text
        end

      profiles.css(".details-container").each do |bio|
        single_profile.merge!(:bio => bio.css(".description-holder p").text)
      end
      single_profile
    end

end

#twitter: .vitals-container .social-icon-container a href
#linkedin: .vitals-container .social-icon-container a href
#github: .vitals-container .social-icon-container a href
#blog: .vitals-container .social-icon-container a href
#profile_quote: .vitals-container .vitals-text-container .profile-quote
#bio: .bio-block .details-block .description-holder p
