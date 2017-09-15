require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    result = []
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    student_array = doc.css("div.student-card")

    student_array.each do |student_card|
      name = student_card.css("h4.student-name").text
      location = student_card.css("p.student-location").text
      profile_url = student_card.css("a")[0]["href"]

      student = {:name => name, :location => location, :profile_url => profile_url}
      result << student
    end #end each
    result
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open("#{profile_url}"))

    social_media =
    doc.css("div.social-icon-container a").collect do |element|
      element['href']
    end

    twitter_url = social_media.detect do |link|
      link.include?("twitter")
    end


    linkedin_url = social_media.detect do |link|
      link.include?("linkedin")
    end

    github_url = social_media.detect do |link|
      link.include?("github")
    end

    blog_url_array = social_media.reject do |link|
      link.include?("github") || link.include?("linkedin") ||link.include?("twitter")
    end

    blog_url = blog_url_array.join("")

    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text

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
