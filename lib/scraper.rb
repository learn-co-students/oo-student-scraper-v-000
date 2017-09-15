require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_hash_array = []
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    #create array of students (as xml elements)
    student_xml_array = doc.css("div.student-card")

    #iterate through array, find attributes, create a hash of attributes for each student_card
    #return array of hashes
    student_xml_array.each do |student_attributes|
      name = student_attributes.css("h4.student-name").text
      location = student_attributes.css("p.student-location").text
      profile_url = student_attributes.css("a")[0]["href"]

      student_hash = {:name => name, :location => location, :profile_url => profile_url}
      student_hash_array << student_hash
    end
    student_hash_array
  end #end method


  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open("#{profile_url}"))

    #scrape for social media links and return as array
    social_media_array =
    doc.css("div.social-icon-container a").collect do |element|
      element['href']
    end

    ########################################################################################
    #iterate over array and assign particular links to a varlable if those links are included.
    #variables will later be used to set key values for student hash

    twitter_url = social_media_array.detect do |link|
      link.include?("twitter")
    end


    linkedin_url = social_media_array.detect do |link|
      link.include?("linkedin")
    end

    github_url = social_media_array.detect do |link|
      link.include?("github")
    end

    #set blog url and re-format to match test expectation
    blog_url_array = social_media_array.reject do |link|
      link.include?("github") || link.include?("linkedin") ||link.include?("twitter")
    end
    blog_url = blog_url_array.join("")

    #scrape and set variables for rest of attributes
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text

    ########################################################################################

    #use variables above to set hash key values. Delete particular keys if key value is nil/empty. Return hash
    scraped_student = {
      :twitter => twitter_url,
      :linkedin => linkedin_url,
      :github => github_url,
      :blog => blog_url,
      :profile_quote => profile_quote,
      :bio => bio
    }.delete_if{ |k,v| v.nil? || v == ""}

    scraped_student

  end

end
