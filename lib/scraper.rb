
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


# expected output --> {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []
    doc.css("div.student-card").each do |student|
      students << {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student.at("a[href]").attr('href')}
    end
    students
  end
  
  def self.scrape_profile_page(profile_url)
    urls = []
    doc = Nokogiri::HTML(open(profile_url))
    attributes = {}
    doc.css("div.social-icon-container a").each do |link|
      urls << link.attribute('href').value
    end

    urls.each do |url|
      if url.include? "twitter.com"
        attributes.merge!(twitter: url)
      elsif url.include? "linkedin.com"
        attributes.merge!(linkedin: url)
      elsif url.include? "facebook.com"
        attributes.merge!(facebook: url)
      elsif url.include? "github.com"
        attributes.merge!(github: url)
      else
        attributes.merge!(blog: url)
      end
    end

    attributes.merge!(profile_quote: doc.css("div.vitals-text-container div.profile-quote").text.strip)
    attributes.merge!(bio: doc.css("div.bio-content.content-holder div.description-holder").text.strip)
    #binding.pry
    attributes

#profile quote doc.css("div.vitals-text-container div.profile-quote").text
#bio  doc.css("div.bio-content.content-holder div.description-holder").text

  end

end
