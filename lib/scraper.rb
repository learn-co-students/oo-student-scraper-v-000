require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

# the return value of this method should be an array of hashes in which each hash represents
# a single student.
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # students = doc.css(".roster-cards-container")   "This was not the right selector."
    students = doc.css(".student-card")
    # binding.pry
    scraped_students = []

    students.each do |student|

      hash = { name: student.css(".student-name")[0].text,
        location: student.css(".student-location")[0].text,
        profile_url: student.css("a")[0]['href'] }
      scraped_students << hash
      end
      scraped_students
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

       social_urls = {}
      #  social_urls = Hash.new

        doc.css(".social-icon-container").css("a").each do |social|
          if social['href'].include?("twitter")
            social_urls[:twitter] = social['href']

          elsif social['href'].include?("linkedin")
            social_urls[:linkedin] = social['href']

          elsif social['href'].include?("github")
            social_urls[:github] = social['href']

          elsif social['href'].include?(".com")
            social_urls[:blog] = social['href']
            # binding.pry
          end
        end

      if doc.css(".vitals-text-container").css(".profile-quote").text.include?("")
        social_urls[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
      # if doc.css(".vitals-text-container").css(".profile-quote").text != ("")
      #    social_urls[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
      end

      if doc.css(".details-container").css("p").text != ("")
        social_urls[:bio] = doc.css(".details-container").css("p").text
      # if doc.css(".details-container").css("p").text.include?("")
      #   social_urls[:bio] = doc.css(".details-container").css("p").text
      end
      social_urls
  end

  

end
