require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :index_url

  @index_url = Nokogiri::HTML(File.read('fixtures/student-site/index.html'))


  def self.scrape_index_page(index_url)
    student_index_array = []
    @index_url.css(".student-card").each do |student|
      # binding.pry
      student_index_array << student_hash = {
        name: student.css(".card-text-container h4.student-name").text,
        location: student.css(".card-text-container p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
    student_profile_hash = {}
    profile.css(".main-wrapper .social-icon-container a").each do |link|
      url_string = link.attribute("href").value
      if url_string.include?("twitter.com")
        student_profile_hash[:twitter] = url_string
      elsif url_string.include?("linkedin.com")
        student_profile_hash[:linkedin] = url_string
      elsif url_string.include?("github.com")
        student_profile_hash[:github] = url_string
      elsif url_string.include?("youtube.com")
        student_profile_hash[:youtube] = url_string
      elsif !(url_string.nil?)
        student_profile_hash[:blog] = url_string
      end
    end
    student_profile_hash[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text
    student_profile_hash[:bio] = profile.css(".details-container .bio-block .bio-content .description-holder p").text
    # binding.pry
    student_profile_hash
  end

end
