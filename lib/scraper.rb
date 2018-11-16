require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  index_url = 'fixtures/student-site/index.html'

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = []
    #roster.css(".roster-cards-container").each do |student|
    roster.css(".student-card").each do |student|
      #student.css("div.id").text
      #binding.pry
      students << {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #This is a class method that should take in an argument of a student's profile URL. It should use
    #Nokogiri and Open-URI to access that page. The return value of this method should be a hash in which
    #the key/value pairs describe an individual student. Some students don't have a twitter or some other
    #social link. Be sure to be able to handle that.
    #twitter url, linkedin, gituhub url, blog url, profile quote, bio
    html = File.read(profile_url)
    roster = Nokogiri::HTML(html)
    profile = {}
    #binding.pry
      socials = []
      roster.css(".social-icon-container").css("a").each do |social_media|
        socials << social_media.attribute("href").value
      end
      profile = {
        #:twitter => socials.detect{ |site| site.include? 'twitter'},
        #:linkedin => socials.detect{ |site| site.include? 'linkedin'},
        #:github => socials.detect{ |site| site.include? 'github'},
        #:blog => socials[3],
        :profile_quote => roster.css(".vitals-text-container").css(".profile-quote").text,
        :bio => roster.css(".details-container").css("p").text
      }
      if socials.detect{ |site| site.include? 'twitter'} != nil
        profile[:twitter] = socials.detect{ |site| site.include? 'twitter'}
      end
      if socials.detect{ |site| site.include? 'linkedin'} != nil
        profile[:linkedin] = socials.detect{ |site| site.include? 'linkedin'}
      end
      if socials.detect{ |site| site.include? 'github'} != nil
        profile[:github] = socials.detect{|site| site.include? 'github'}
      end
      if socials.count >= 4
        profile[:blog] = socials[3]
      end
      profile
      #binding.pry
  end
end
#Scraper.scrape_profile_page('./fixtures/student-site/students/alvin-lu.html')
