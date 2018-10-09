require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@student_info = []

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    
    student_site.css(".student-card").each do |student|
      i = 0
      student_hash = {
        :name => student.css(".card-text-container").css(".student-name").text,
        :location => student.css(".card-text-container").css(".student-location").text,
        :profile_url => student.css("a")[i]["href"]
      }
      @@student_info << student_hash
      i += 1
    end
    # binding.pry
    @@student_info
  end

  def self.scrape_profile_page(profile_url)
    # @@student_info.each do |student|
    #   i = 0
    #   profile = student[i][:profile_url]
    #   # all method code in here
    #   i += 1
    # end
    # profile_url = "./fixtures/student-site/#{profile}"

    student_profile = Nokogiri::HTML(open(profile_url))
    student_profile_hash = {}
    
    
    student_profile.css(".profile").each do |info|

      count = info.css(".vitals-container .social-icon-container a").count
      
      i = 0
      while i < count do
        social = info.css(".vitals-container .social-icon-container a")[i]["href"]
        if social.match(/twitter/)
          student_profile_hash[:twitter] = social
        elsif social.match(/linkedin/)
          student_profile_hash[:linkedin] = social
        elsif social.match(/github/)
          student_profile_hash[:github] = social
        elsif social != nil
          student_profile_hash[:blog] = social
        end
        i += 1
      end

      student_profile_hash[:profile_quote] = info.css(".vitals-container .vitals-text-container .profile-quote").text
      student_profile_hash[:bio] = info.css(".details-container .bio-block .bio-content .description-holder p").text

    end
    student_profile_hash
  end

end

