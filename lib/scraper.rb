require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_index = Nokogiri::HTML(html)
    student_basics = []
    student_index.css("div.student-card").each do |student|
      student_basics << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => (student.css("a").map {|link| link['href']})[0]
      }
    end
    student_basics
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    student = Nokogiri::HTML(html)

    student_links = student.css("div.social-icon-container a").map {|link| link['href']}

    student_profile = {}
        student_links.each do |link|
            if link.include?("twitter")
              student_profile.merge!(twitter: student_links.select {|link| link.include?("twitter")}[0])
            elsif link.include?("linkedin")
              student_profile.merge!(linkedin: student_links.select {|link| link.include?("linkedin")}[0])
            elsif link.include?("github")
              student_profile.merge!(github: student_links.select {|link| link.include?("github")}[0])
            elsif link.include?("youtube")
              student_profile.merge!(youtube: student_links.select {|link| link.include?("youtube")}[0])
            elsif link.end_with?(".com/")
              student_profile.merge!(blog: student_links.select {|link| link.end_with? ".com/"}[0])
            end
        end
        student_profile.merge!(profile_quote: student.css("div.profile-quote").text)
        student_profile.merge!(bio: student.css("div.description-holder p").text)

    student_profile
  end
end
