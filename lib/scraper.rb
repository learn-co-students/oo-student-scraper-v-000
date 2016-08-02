require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    url = Nokogiri::HTML(open(index_url))

    students = []

    url.css("div.student-card").each do |student_card|
      student = {
      :name => student_card.css("h4.student-name").text,
      :location => student_card.css("p.student-location").text,
      :profile_url =>"./fixtures/student-site/" + student_card.css("a").attribute("href").value
      }
      students << student
    end
    return students
  end


  def self.scrape_profile_page(profile_url)
    url = Nokogiri::HTML(open(profile_url))

    student_profile = {}
    links = url.css("div.social-icon-container")
    links.each do |link|
      link_text = link.css("a").attribute("href").text
      link_img = link.css("img.social-icon").attribute("src").text

      if (link_img.include?("github-icon"))
        student_profile[:github] = link_text
        puts "github"
      elsif (link_img.include?("twitter"))
        student_profile[:twitter] = link_text
        puts "twitter"
      elsif (link_img.include?("linkedin"))
        student_profile[:linkedin] = link_text
        puts "linkedin"
      else
        student_profile[:blog] = link_text
        puts"what the fuck"

      end
    end

    student_profile[:bio] = url.css("div.bio-content p").text
    return student_profile

  end

end
