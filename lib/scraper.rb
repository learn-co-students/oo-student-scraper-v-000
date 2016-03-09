require 'open-uri'
require 'pry'

class Scraper

    # name = doc.css("h4.student-name").text
    # location = doc.css("p.student-location").text
    # profile_url = doc.css(".student-card a").attribute("href").value
    # complete_profile_url = "http://127.0.0.1:4000/" + profile_url

    # scraped profile_url from:
    # [#<Nokogiri::XML::Element:0x3fff3602351c name="a" attributes=[#<Nokogiri::XML::Attr:0x3fff36023314 name="href" value="students/ryan-johnson.html">]
    # .student-card was the div class containing all of the student cards
      # 'a' has the following attribute:
        # 'name' = "href"
          # which has 'value' = "students/ryan-johnson.html"

  def self.scrape_index_page(index_url)
    # to select div id use '#'
    # to select div class use '.'
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new
  
      doc.css("div.student-card a").each do |info|
        # profile_url = "http://127.0.0.1:4000/#{info.attribute("href").value}"
        # refactored info.attribute("href").value => info["href"]
        profile_url = "http://127.0.0.1:4000/#{info["href"]}"
        name = info.css("h4.student-name").text
        location = info.css("p.student-location").text

        students << {:name => name, location: location, profile_url: profile_url}
      end
      students
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = Hash.new

    # need to collect all of the href links from "a" into an array
    # then select each element and set it equal to the social media it ='s

    social_container = doc.css('.social-icon-container')
    social_urls_array = Array.new
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css(".description-holder p").text

    social_container.each do |urls|
      urls.css("a").each do |url|
        #social_urls_array << url.attribute("href").value
        #refactored to:
        social_urls_array << url["href"]  
      end

      # example: social_urls_array => 
      # ["https://twitter.com/jmburges",
      # "https://www.linkedin.com/in/jmburges", 
      # "https://github.com/jmburges", 
      # "http://joemburgess.com/"]

    twitter = "n/a" # made flags/switch with placeholder value
    linkedin = "n/a"  
    github = "n/a"
    blog = "n/a"

    social_urls_array.each do |url|
      if url.include?("twitter")
        twitter = url
      elsif url.include?("linkedin")
        linkedin = url
      elsif url.include?("github")
        github = url
      else
        blog = url
      end
    end

    student_info = {twitter: twitter, linkedin: linkedin, github: github, blog: blog, profile_quote: profile_quote, bio: bio}
    student_info.reject! {|k,v| v.include?("n/a")}  
    end
    student_info
  end

end

