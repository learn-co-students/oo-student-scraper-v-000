require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    roster = doc.css(".student-card")
    roster.each do |student|
      hash = {
       :name => student.css(".card-text-container .student-name").text,
       :location => student.css(".card-text-container .student-location").text,
       :profile_url => index_url + student.css("a").attribute("href").value,
     }
     scraped_students << hash
   end
   scraped_students
 end

 def self.scrape_profile_page(profile_url)
  html = open(profile_url)
  doc = Nokogiri::HTML(html)
  scrape_profile = {
    :profile_quote => doc.css(".vitals-container .vitals-text-container .profile-quote").text,
    :bio => doc.css(".details-container .bio-block .bio-content .description-holder p").text
  }

  socials = doc.css(".vitals-container .social-icon-container a")
  socials.each do |social|
      # binding.pry
      if social.attribute("href").value.include?("twitter")
        scrape_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        scrape_profile[:github] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        scrape_profile[:linkedin] = social.attribute("href").value
      else
        scrape_profile[:blog] = social.attribute("href").value
      end
    end
    scrape_profile
  end

end

