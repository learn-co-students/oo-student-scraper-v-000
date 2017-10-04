require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    student_array = []
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      link = student.css("a")
      profile_url = link[0]["href"]
      student_array << Hash[:name=> name, :location => location, :profile_url => profile_url]
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile_page = Hash.new
    doc.css(".social-icon-container a").each { |sm|
      if sm.values[0].match(/(twitter)/) != nil
        twitter = sm.values[0]
        profile_page[:twitter] = twitter
      elsif sm.values[0].match(/(linkedin)/) != nil
        linkedin = sm.values[0]
        profile_page[:linkedin] = linkedin
      elsif sm.values[0].match(/(github)/) != nil
        github = sm.values[0]
        profile_page[:github] = github
      else
        blog = sm.values[0]
        profile_page[:blog] = blog
      end
    }
      profile_quote = doc.css(".profile-quote").text
      profile_page[:profile_quote] = profile_quote
      bio = doc.css(".bio-content .description-holder p").text
      profile_page[:bio] = bio

    profile_page
    #sm img urls doc.css(".social-icon-container a img")[0].values[1]
    #sm url doc.css(".social-icon-container a[href]")[0].values[0]
  #blog
  #profile_quote
  #bio

  end

end
