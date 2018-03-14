require 'open-uri'
require 'pry'
require 'nokogiri' #added by Tom

class Scraper

  def self.scrape_index_page(index_url)
    #array will contain hashes
    students_arr = []
    students_hash = {}

    #transform our http response into a nokogiri object
    index_page = Nokogiri::HTML(open(index_url))

    #iterate through all students on the index page
    index_page.css('.student-card').each { |student|

      #one hash per student
      students_hash = {
          :name => student.css('.student-name').text,
          :location => student.css('.student-location').text,
          :profile_url => "./fixtures/student-site/#{student.css('a').attribute('href').text}"
      }

      #push hash into array
      students_arr << students_hash
    }
# binding.pry
    students_arr
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    social_arr = []
    social_hash = {}

    #transform our http response into a nokogiri object
    profile_page = Nokogiri::HTML(open(profile_url))

    #grab available links from css selector and put into array
    social_links = profile_page.css('.social-icon-container').each { |link|
        social_arr = link.css("a").collect { |x| x.attribute("href").value }
    }

    #move available links into hash of social links
    social_arr.each { |link|
      if link.include?("twitter")
        social_hash.store(:twitter,link)
      elsif link.include?("linkedin")
        social_hash.store(:linkedin, link)
      elsif link.include?("github")
        social_hash.store(:github, link)
      else
        social_hash.store(:blog, link)
      end
    }
    #grab the other profile details from page and put into hash
    profile_page.css('.main-wrapper').each { |profile|
      profile_hash = {
        :profile_quote => profile.css('.profile-quote').text,
        :bio => profile.css('.details-container .description-holder p').text
      }
    }

    #combine social links hash and regular profile hash
    profile_hash.merge!(social_hash)

# binding.pry
    profile_hash
  end
end
