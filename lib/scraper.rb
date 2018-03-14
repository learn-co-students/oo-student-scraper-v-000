require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)
    students = {}
    arr = []


    index_page.css(".student-card").each do |student|
      students = {
        :name  => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }

      arr << students
    end

    arr

  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}
    tmp = []
    twitter, linkedin, github, blog = nil

    profile_page.css(".social-icon-container a").each do |i|
        tmp << i.attribute("href").value
    end

    tmp.each do |i|
      if i.include?("twitter")
        twitter = i
      elsif i.include?("linkedin")
        linkedin = i
      elsif i.include?("github")
        github = i
      else
        blog = i
      end
    end

    student = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => profile_page.css(".profile-quote").text,
      :bio => profile_page.css(".description-holder p").text
    }


  student.delete_if { |key, value| value.nil? }
  #binding.pry
  end

end
