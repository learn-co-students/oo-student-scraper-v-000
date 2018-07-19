require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_scrape = Nokogiri::HTML(open(index_url)).css("div.student-card")
    student_hash_index = []
    index_scrape.each do |student|
      student_hash_index<< {
        name: student.css("div.card-text-container h4.student-name").text,
        location: student.css("div.card-text-container p.student-location").text,
        profile_url: student.css("a").first["href"]
      }
    end
    student_hash_index
  end

  def self.scrape_profile_page(profile_url)
    profile_scrape = Nokogiri::HTML(open(profile_url)).css("div.main-wrapper.profile")

    student_hash_profile = []
    profile_scrape.each do |profile|
      social_links = profile.css("div div.social-icon-container a").map {|link| link.attribute("href").to_s}
      linkedin = social_links.find{|link| link.match(/.*\blinkedin.*/)}
      github = social_links.find{|link| /.*\bgithub.*/}
      twitter = social_links.find{|link| /.*\twitter.*/}
      blog = social_links.find{|link| link != linkedin && link != github && link != twitter}
        student_hash_profile <<{
          linkedin: profile.css("div div.social-icon-container a"),
          github: "something",
          blog: "something",
          profile_quote: profile.css("div.vitals-text-container div.profile-quote").text,
          bio: profile.css("div.details-container div div div.description-holder p").text
        }
        binding.pry
      end
  end

end
