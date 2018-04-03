require 'open-uri'
require 'pry'

  #each student: page.css("div.student-card")
  #name: page.css("h4.student-name")
  #location: page.css("p.student-location")
  #profile_url: page.css("a").attribute("href").value

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("./fixtures/student-site/index.html")
    page = Nokogiri::HTML(html)
    students = []

    page.css("div.student-card").each do |student|
      each_student = { :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value }

        students << each_student
      end
      students
  end


  def self.scrape_profile_page(profile_url)
    site = File.read(profile_url)
    student_site = Nokogiri::HTML(site)
    student_hash = {}

    student_site.css("div.social-icon-container a").each do |link|
      web = link.attribute("href").value
      if web.include?("twitter")
        student_hash[:twitter] = web
      elsif web.include?("linkedin")
        student_hash[:linkedin] = web
      elsif web.include?("github")
        student_hash[:github] = web
      else
        student_hash[:blog] = web
      end
    end
      student_hash[:profile_quote] = student_site.css("div.profile-quote").text
      student_hash[:bio] = student_site.css("div.description-holder p").text
      student_hash
  end

end
