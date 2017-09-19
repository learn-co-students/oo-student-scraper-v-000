require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = {}
        # is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student (FAILED - 1)
  end

  def self.scrape_profile_page(profile_url)
    # is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student (FAILED - 2)
    # can handle profile pages without all of the social links (FAILED - 3)
  end

end
