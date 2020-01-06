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
    # courses = doc.css("#2a778efd-1685-5ec6-9e5a-0843d6a88b7b .inlineMobileLeft-2Yo002.imageTextBlockGrid3-2XAK6G")
    #
    # courses.each do |course|
    #   puts course.text.strip
    # end

    # social_urls = doc.css(".social-icon-container a")
    # # binding.pry
    #   social_urls.each do |social_url|
    #     social_url
    #     binding.pry
    #   end

      social_urls = Hash.new

       temp_twitter = ""
       temp_linkedin = ""
       temp_github = ""
       temp_blog =  ""
       temp_profile_quote = ""
       temp_bio = ""

      #  doc.css(".social-icon-container").css("a")
      #  binding.pry

      if doc.css(".social-icon-container").css("a")[0]['href'].include?("twitter.com")
        social_urls[:twitter] = doc.css(".social-icon-container").css("a")[0]['href']
      end

      if doc.css(".social-icon-container").css("a")[1]['href'].include?("linkedin.com")
        social_urls[:linkedin] = doc.css(".social-icon-container").css("a")[1]['href']
      end

      if doc.css(".social-icon-container").css("a")[2]['href'].include?("github.com")
        social_urls[:github] = doc.css(".social-icon-container").css("a")[2]['href']
      end

      if doc.css(".social-icon-container").css("a")[3]['href'].include?(".com")
        social_urls[:blog] = doc.css(".social-icon-container").css("a")[3]['href']
      end

      if doc.css(".vitals-text-container").css(".profile-quote").text.include?("")
        social_urls[:blog] = doc.css(".vitals-text-container").css(".profile-quote").text
      end

      if doc.css(".details-container").css("p").text.include?("")
        social_urls[:bio] = doc.css(".details-container").css("p").text
      end
      binding.pry

      # doc.css(".social-icon-container").css("a")
      # doc.css(".social-icon-container").css("a")[0]['href']
      # binding.pry
      #
      # social_urls = { twitter: temp_twitter, linkedin: temp_linkedin, github: temp_github, blog: temp_blog, profile_quote: temp_profile_quote,
      #   bio: temp_bio }

      # social_urls = { twitter: doc.css(".social-icon-container").css("a")[0]['href'],
      #   linkedin: doc.css(".social-icon-container").css("a")[1]['href'],
      #   github: doc.css(".social-icon-container").css("a")[2]['href'],
      #   blog: doc.css(".social-icon-container").css("a")[3]['href'],
      #   profile_quote: doc.css(".vitals-text-container").css(".profile-quote").text,
      #   bio: doc.css(".details-container").css("p").text }
        # binding.pry
      #

      #   social_urls = { twitter: doc.css(".vitals-container").css("a")[0]['href'],
      #     linkedin: doc.css(".vitals-container").css("a")[1]['href'],
      #     github: doc.css(".vitals-container").css("a")[2]['href'],
      #     blog: doc.css(".vitals-container").css("a")[3]['href'],
      #     profile_quote: doc.css(".vitals-container").css(".profile-quote").text,
      #     bio: doc.css(".details-container").css("p").text }

      # if doc.css(".social-icon-container").css("a") != nil ||
      #   doc.css(".vitals-text-container").css(".profile-quote") != nil ||
      #   doc.css(".details-container").css("p") != nil
      #   social_urls[:twitter] = doc.css(".social-icon-container").css("a")[0]['href']
      #   social_urls[:linkedin] = doc.css(".social-icon-container").css("a")[1]['href']
      #   social_urls[:github] = doc.css(".social-icon-container").css("a")[2]['href']
      #   social_urls[:blog] = doc.css(".social-icon-container").css("a")[3]['href']
      #   social_urls[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
      #   social_urls[:bio] = doc.css(".details-container").css("p").text
      # end
      # social_urls

      # binding.pry

      # social_urls = { twitter: doc.css(".social-icon-container").css("a")[0]['href'],
      #   linkedin: doc.css(".social-icon-container").css("a")[1]['href'],
      #   github: doc.css(".social-icon-container").css("a")[2]['href'],
      #   blog: doc.css(".social-icon-container").css("a")[3]['href'],
      #   profile_quote: doc.css(".vitals-text-container").css(".profile-quote").text,
      #   bio: doc.css(".details-container").css("p").text }
        # binding.pry
        # Coach said to try this concept for each link:
        # use it on this section  of "doc.css(".social-icon-container").css("a")" and check that it is not nil.
        # if not nil you can then take the whole link above and add it to the key.
        # if doc.css(".social-icon-container").css("a") != nil
        #   then social_urls = { twitter: doc.css(".social-icon-container").css("a")[0]['href'] }
        # social_urls.each do |key, value|
        # social_urls.reject { |k,v| v.nil? }
        # binding.pry
        # end
        # binding.pry
  end

end
