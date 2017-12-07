require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = File.read('fixtures/student-site/index.html')
    student_site = Nokogiri::HTML(html)
    #project  student_site.css("div.student-card")
    #student student_site.css("div.student-card h4")
    #location student_site.css("div.student-card p")
    #link student_site.css("div.student-card a").attribute("href").value

    students = []
    #binding.pry
     student_site.css("div.student-card").each do |project| #.children
       students << {
         :name => project.css("h4").text,
         :location => project.css("p").text,
         :profile_url => project.css("a").attribute("href").value
       }
     end

     students
    #binding.pry

  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_profile = Nokogiri::HTML(html)

    student = {}
    #binding.pry

    social_links = student_profile.css("div.social-icon-container").children.css("a").map {|link_check| link_check.attribute('href').value}
      #binding.pry
      social_links.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        else
          student[:blog] = link
        end
      end
      #binding.pry

      student[:profile_quote] = student_profile.css(".profile-quote").text if student_profile.css(".profile-quote")
      student[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text if student_profile.css("div.bio-content.content-holder div.description-holder p")


    student
    #binding.pry
  end

end

=begin

student[text.to_sym] {
  #binding.pry
  :twitter => social.css("a").attribute("href").value if social.css("") != nil
  :linkedin => social.css("a").attribute("href").value if social.css("") != nil
  :github => social.css("a").attribute("href").value if social.css("") != nil
  :blog => social.css("a").attribute("href").value if social.css("") != nil
  :profile_quote => social.css("a").attribute("href").value if social.css("") != nil
  :bio => social.css("a").attribute("href").value if social.css("") != nil

}

=end
