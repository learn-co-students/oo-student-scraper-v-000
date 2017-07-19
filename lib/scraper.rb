require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
#index_url = "http://127.0.0.1:8080/code/labs/oo-student-scraper-v-000/fixtures/student-site/"

# collection = doc.css(".student-card")
# name = doc.css(".student-card").first.css("h4").text
# location = doc.css(".student-card").first.css(".student-location").text
# profile_link = doc.css(".student-card").first.css("a")
# profile_url = "./fixtures/student-site/" + profile_link[0]["href"]

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    array = []

    doc.css(".student-card").each do |student|
      student_hash = {:name => student.css("h4").text,
        :location => student.css(".student-location").text,
        :profile_url => index_url + student.css("a")[0]["href"]}
      array << student_hash
    end
    array
  end

  def compact
    delete_if { |k, v| v.nil? }
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    #profile_url = "http://127.0.0.1:8080/code/labs/oo-student-scraper-v-000/fixtures/student-site/students/joe-burgess.html"
    #profile_url = "http://127.0.0.1:8080/code/labs/oo-student-scraper-v-000/fixtures/student-site/students/david-kim.html"
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

      if doc.css(".social-icon-container a")[0] != nil
        soc_link_1 = doc.css(".social-icon-container a")[0]["href"]
      else
        soc_link_1 = "Not Provided"
      end
      if doc.css(".social-icon-container a")[1] != nil
        soc_link_2 = doc.css(".social-icon-container a")[1]["href"]
      else
        soc_link_2 = "Not Provided"
      end
      if doc.css(".social-icon-container a")[2] != nil
        soc_link_3 = doc.css(".social-icon-container a")[2]["href"]
      else
        soc_link_3 = "Not Provided"
      end
      if doc.css(".social-icon-container a")[3] != nil
        soc_link_4 = doc.css(".social-icon-container a")[3]["href"]
      else
        soc_link_4 = "Not Provided"
      end

      if soc_link_1.include?("twitter")
        twitter = soc_link_1
      elsif soc_link_1.include?("linkedin")
        linked_in = soc_link_1
      elsif soc_link_1.include?("github")
        github = soc_link_1
      elsif !soc_link_1.include?("twitter") && !soc_link_1.include?("linkedin") && !soc_link_1.include?("github") && soc_link_1 != "Not Provided"
        blog = soc_link_1
      end

      if soc_link_2.include?("twitter")
        twitter = soc_link_2
      elsif soc_link_2.include?("linkedin")
        linked_in = soc_link_2
      elsif soc_link_2.include?("github")
        github = soc_link_2
      elsif !soc_link_2.include?("twitter") && !soc_link_2.include?("linkedin") && !soc_link_2.include?("github") && soc_link_2 != "Not Provided"
        blog = soc_link_2
      end

      if soc_link_3.include?("twitter")
        twitter = soc_link_3
      elsif soc_link_3.include?("linkedin")
        linked_in = soc_link_3
      elsif soc_link_3.include?("github")
        github = soc_link_3
      elsif !soc_link_3.include?("twitter") && !soc_link_3.include?("linkedin") && !soc_link_3.include?("github") && soc_link_3 != "Not Provided"
        blog = soc_link_3
      end

      if soc_link_4.include?("twitter")
        twitter = soc_link_4
      elsif soc_link_4.include?("linkedin")
        linked_in = soc_link_4
      elsif soc_link_4.include?("github")
        github = soc_link_4
      elsif !soc_link_4.include?("twitter") && !soc_link_4.include?("linkedin") && !soc_link_4.include?("github") && soc_link_4 != "Not Provided"
        blog = soc_link_4
      end

      #VITALS#
      name = doc.css(".vitals-text-container .profile-name").text
      location = doc.css(".vitals-text-container .profile-location").text
      quote = doc.css(".vitals-text-container .profile-quote").text

      #BIO#
      bio_heading = doc.css(".bio-content.content-holder .title-holder h3").text
      bio_body = doc.css(".bio-content.content-holder .description-holder p").text
      education_title = doc.css(".education-content.content-holder .title-holder h3").text
      education_loc = doc.css(".education-content.content-holder .description-holder h4").text
      education_desc = doc.css(".education-content.content-holder .description-holder h5").text

    student_profile_hash = {
      #SOCIAL#
      :twitter => twitter,
      :linkedin => linked_in,
      :github => github,
      :blog => blog,
      #VITALS#
      #:name => name,
      #:location =>location,
      :profile_quote => quote,
      #BIO#
      #:bio_heading => bio_heading,
      :bio => bio_body,
      #:education_title => education_title,
      #:education_loc => education_loc,
      #:education_desc => education_desc
      }
      student_profile_hash.select {|k, v| v }
  end

end
