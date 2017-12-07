require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
        #index_url = "./fixtures/student-site/index.html"
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
                #student_hash cannot be created here on line 11 without causing pass by reference issues later in the block div.search...
    s_details = doc.search("div.roster-cards-container")
                #location = doc.search("p.student-location").text
                #profile_url = doc.search("a").text

    s_details.each do |div|
      div.search("div.student-card a").map do |s|
          student_hash = {}           #This is a key component to this block.  Without creating the hash inside this block Ruby's pass by reference(object id#) would cause student_array to be filled 110 instances of the last scraped values because the object id's would be the same and the it would simply rewrite the object when it saw the same ID.
          name = s.search("h4.student-name").text
          location = s.search("p.student-location").text
          profile_url = s.attr("href")
          student_hash[:name] = name
          student_hash[:location] = location
          student_hash[:profile_url] = profile_url
          student_array << student_hash
      end
    end
    student_array
  end

      #[{name: "student name", location: "student location", profile: "profile"}, ]

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #profile_page = []
    social_media_links = []
    profile_page_hash = {}

    profile_quote = doc.search("div.profile-quote").text
    bio = doc.search("div.description-holder p").text
      social_media = doc.search("div.social-icon-container a").each do |sml|
          social_media_link = []
          social_media_link = sml.attr("href")
          social_media_links << social_media_link
          end
          #Creating the hash
    profile_page_hash[:twitter] = (social_media_links.select {|site| site.start_with?("https://twitter.com")}).join
    profile_page_hash[:linkedin] = (social_media_links.select  {|site| site.start_with?("https://www.linkedin.com")}).join
    profile_page_hash[:github] = (social_media_links.select {|site| site.start_with?("https://github.com")}).join
      if profile_page_hash.key?(:twitter) == true && profile_page_hash.key?(:linkedin) == true && profile_page_hash.key?(:github) == true && social_media_links.count > 3
        profile_page_hash[:blog] = social_media_links[-1]
      end
    profile_page_hash[:profile_quote] = profile_quote
    profile_page_hash[:bio] = bio
        #Removing nil values
    scraped_student = profile_page_hash
      #The hash

    scraped_student.delete_if {|k, v| v.empty?}
    scraped_student
    end


end
