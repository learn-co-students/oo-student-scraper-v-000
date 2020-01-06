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

      social_urls = Hash.new

       temp_twitter = ""
       temp_linkedin = ""
       temp_github = ""
       temp_blog =  ""
       temp_profile_quote = ""
       temp_bio = ""


      if doc.css(".social-icon-container").css("a")[0]['href'].include?("twitter.com")
        twitter = doc.css(".social-icon-container").css("a")[0]['href']
        social_urls[:twitter] = twitter
      else social_urls[:twitter] = temp_twitter
      end

      if doc.css(".social-icon-container").css("a")[1]['href'].include?("linkedin.com")
        linkedin = doc.css(".social-icon-container").css("a")[1]['href']
        social_urls[:linkedin] = linkedin
      else social_urls[:linkedin] = temp_linkedin
      end

      if doc.css(".social-icon-container").css("a")[2]['href'].include?("github.com")
        github = doc.css(".social-icon-container").css("a")[2]['href']
        social_urls[:github] = github
      else social_urls[:github] = temp_github
      end

      if doc.css(".social-icon-container").css("a")[3]['href'].include?(".com")
        blog = doc.css(".social-icon-container").css("a")[3]['href']
        social_urls[:blog] = blog
      else social_urls[:blog] = temp_blog
      end

      if doc.css(".vitals-text-container").css(".profile-quote").text.include?("")
        profile_quote = doc.css(".vitals-text-container").css(".profile-quote").text
        social_urls = { profile_quote: profile_quote }
        # social_urls[:blog] = profile_quote
      # else social_urls[:blog] = temp_profile_quote
      else social_urls = { profile_quote: temp_profile_quote }
      end

      if doc.css(".details-container").css("p").text.include?("")
        bio = doc.css(".details-container").css("p").text
        social_urls[:bio] = bio
      else social_urls[:bio] = temp_bio
      end

      # social_urls = { twitter: temp_twitter, linkedin: temp_linkedin, github: temp_github, blog: temp_blog, profile_quote: temp_profile_quote,
      #   bio: temp_bio }
      # binding.pry

      # social_urls = { twitter: temp_twitter, linkedin: temp_linkedin, github: temp_github, blog: temp_blog, profile_quote: temp_profile_quote,
      #   bio: temp_bio }

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
