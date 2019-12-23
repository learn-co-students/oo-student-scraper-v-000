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

      # binding.pry
      # scraped_student = Hash.new{}
      # scraped_student = Hash.new { |hash, key| hash[key] = nil }
      # binding.pry
      # scraped_student[:twitter] = doc.css(".social-icon-container").css("a")[0]['href']
      # scraped_student[:linkedin] = doc.css(".social-icon-container").css("a")[1]['href']
      # scraped_student[:github] = doc.css(".social-icon-container").css("a")[2]['href']
      # scraped_student[:blog] = doc.css(".social-icon-container").css("a")[3]['href']
      # scraped_student[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
      # scraped_student[:bio] = doc.css(".details-container").css("p").text
      # binding.pry

      social_urls = { twitter: doc.css(".social-icon-container").css("a")[0]['href'],
        linkedin: doc.css(".social-icon-container").css("a")[1]['href'],
        github: doc.css(".social-icon-container").css("a")[2]['href'],
        blog: doc.css(".social-icon-container").css("a")[3]['href'],
        profile_quote: doc.css(".vitals-text-container").css(".profile-quote").text,
        bio: doc.css(".details-container").css("p").text }
        # social_urls = Hash.new(0)
        binding.pry
        # social_urls.default = 0
        # return nil if @social_urls != @social_urls[:twitter] || @social_urls[:linkedin] || @social_urls[:github] || @social_urls[:blog] ||
        #   @social_urls[:profile_url] || @social_urls[:bio]
  end

end
