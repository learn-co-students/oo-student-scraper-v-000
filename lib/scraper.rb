require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("./fixtures/student-site/index.html")
    learn_students = Nokogiri::HTML(html)

    students = learn_students.css("div.student-card").collect do |student|
      {:name => student.css("div.card-text-container h4.student-name").text, :location=>student.css("div.card-text-container p.student-location").text, :profile_url=>student.css("a").attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_profile = Nokogiri::HTML(html)
    scraped_profile = {}
    student_profile.css("div.main-wrapper").each do |studentinfo|
      studentinfo.css("div.vitals-container div.social-icon-container a").each do |socialmediainfo|
        if socialmediainfo.attribute("href").value[0,15] == "https://twitter"
          scraped_profile[:twitter] = socialmediainfo.attribute("href").value
        elsif socialmediainfo.attribute("href").value[0,20] == "https://www.linkedin"
          scraped_profile[:linkedin] = socialmediainfo.attribute("href").value
        elsif socialmediainfo.attribute("href").value[0,14] == "https://github"
          scraped_profile[:github] = socialmediainfo.attribute("href").value
        elsif socialmediainfo.attribute("href").value[0,5] == "http:"
          scraped_profile[:blog] = socialmediainfo.attribute("href").value
        end
      end
        scraped_profile[:profile_quote] = studentinfo.css("div.vitals-text-container div.profile-quote").text
        scraped_profile[:bio] = studentinfo.css("div.description-holder p").text
    end
    scraped_profile
  end
end
