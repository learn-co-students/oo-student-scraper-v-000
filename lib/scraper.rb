require 'nokogiri'
require 'open-uri'
require 'pry'

# get student-cards: doc.css(".roster-cards-container .student-card")
# get student-name: [student].css(".student-name").text
# get student-location: [student].css(".student-location").text
# get student-profile-url: [student].css("a").attribute("href").value

class Scraper

  ## scrapes the index page for:
  ## 1. the student's name
  ## 2. the student's location
  ## 3. the student's profile_url
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".roster-cards-container .student-card")
    students = student_cards.collect do |info|
      info = {
      :name => info.css(".student-name").text,
      :location => info.css(".student-location").text,
      :profile_url => info.css("a").attribute("href").value
      }
    end # collect student info

    students

  end # # scrape_index_page




  # get all links: links = profile_url.css(".vitals-container .social-icon-container a")
  # get twitter-url: links[0]['href']
  # get linkedin-url: links[1]['href']
  # get github-url: links[2]['href']
  # get blog-url: links[3]['href']
  # get profile_quote: profile_url.css(".vitals-container .vitals-text-container .profile-quote").text
  # get bio: profile_url.css(".details-container .description-holder p")


  ## scrapes the profile page for:
  ## 1. social links (twitter, linkedin, github, blog-url)
  ## 2. profile_quote
  ## 3. bio text

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social_links = profile.css(".vitals-container .social-icon-container a")


    student_attributes = {
      :profile_quote => profile.css(".vitals-container .vitals-text-container .profile-quote").text,
      :bio => profile.css(".details-container .description-holder p").text
    }

    social_links.each do |link|
      if link['href'].include?('twitter')
        student_attributes[:twitter] = link['href']
      elsif link['href'].include?('linkedin')
        student_attributes[:linkedin] = link['href']
      elsif link['href'].include?('github')
        student_attributes[:github] = link['href']
      else
        student_attributes[:blog] = link['href']
      end # if 'href' include?
    end # link

    student_attributes

  end # scrape_profile_page

end # class Scraper
