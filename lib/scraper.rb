require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    doc = Nokogiri::HTML (open(index_url))
    doc.css(".student-card").each_with_index do |post, i|
      student_index_array[i] = {
      :name => post.css(".student-name").text,
      :location => post.css(".student-location").text,
      :profile_url => post.css("a")[0]['href']}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    profile_index = {}

    doc = Nokogiri::HTML (open(profile_url))


    links = doc.css(".social-icon-container a").collect{|line| line.attr('href')}

    profile_index[:profile_quote] = doc.css(".profile-quote").text
    profile_index[:bio] = doc.css(".description-holder p").text

    links.each do |link|
          case
          when link.include?("twitter")
            profile_index[:twitter] = link
          when link.include?("linkedin")
            profile_index[:linkedin] = link
          when link.include?("github")
            profile_index[:github] = link
          else
            profile_index[:blog] = link
          end
    end # all links end

    profile_index


  end

end
