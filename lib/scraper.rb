require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@student_info = []

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    
    student_site.css(".student-card a").each do |student|
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attribute("href").value
      }
      @@student_info << student_hash
    end
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

      social = info.css(".vitals-container .social-icon-container a")
      social.each do |links|
        link = links.attribute("href").value
        if link.match(/twitter/)
          student_profile_hash[:twitter] = link
        elsif link.match(/linkedin/)
          student_profile_hash[:linkedin] = link
        elsif link.match(/github/)
          student_profile_hash[:github] = link
        elsif link != nil
          student_profile_hash[:blog] = link
        end
      end

      student_profile_hash[:profile_quote] = info.css(".vitals-container .vitals-text-container .profile-quote").text
      student_profile_hash[:bio] = info.css(".details-container .bio-block .bio-content .description-holder p").text

    end
    student_profile_hash
  end

end

