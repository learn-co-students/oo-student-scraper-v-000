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
        # binding.pry
      scraped_students << hash
      end
      scraped_students
      # binding.pry
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

      social_urls = { twitter: doc.css(".social-icon-container").css("a")[0]['href'],
        linkedin: doc.css(".social-icon-container").css("a")[1]['href'],
        github: doc.css(".social-icon-container").css("a")[2]['href'],
        blog: doc.css(".social-icon-container").css("a")[3]['href'],
        profile_quote: doc.css(".vitals-text-container").css(".profile-quote").text,
        bio: doc.css(".details-container").css("p").text }

        # fetch(key_name) { |key| "default" }

        # contact_info.each { |key, value| print key + ' = ' + value + "\n" }

        # social_urls.fetch(social_urls[:key]) { |key| "Not available" }
        # h.include?(key)

        social_urls.each do |key, value|
          # binding.pry
          if social_urls.include?(key) == false
            # value = "Not available"
            return { :key => "Not available"}
          end
        #   social_urls.fetch(key) { |social_urls[:key]| "Not available" }
        end

        # social_urls.fetch(:twitter, "Not available")
        # social_urls.fetch(:linkedin, "Not available")
        # social_urls.fetch(:github, "Not available")
        # social_urls.fetch(:blog, "Not available")
        # social_urls.fetch(:profile_quote, "Not available")
        # social_urls.fetch(:bio, "Not available")
        # binding.pry

        # social_urls.default = 0
        # return nil if @social_urls != @social_urls[:twitter] || @social_urls[:linkedin] || @social_urls[:github] || @social_urls[:blog] ||
        #   @social_urls[:profile_url] || @social_urls[:bio]
  end

end
