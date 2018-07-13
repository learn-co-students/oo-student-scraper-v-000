require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
 
    doc = Nokogiri::HTML(html)
    students_hash = []
    students = doc.css(".student-card")
    students.each do |student| 
      students_hash << {:name => student.css(".card-text-container h4").text, :location=> student.css(".card-text-container p").text, :profile_url=> student.css("a").attribute('href').value}
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)
     html = open(profile_url)
     doc = Nokogiri::HTML(html)
     profile_data= doc.css(".main-wrapper")
     hrefs = profile_data.css(".social-icon-container a").map { |anchor| anchor["href"] }
     twitter_link = ""
     linkedin_link = ""
     github_link = ""
     blog_link = ""
     hrefs.each do |href|
       if href.include?("twitter")
         twitter_link = href
       elsif href.include?("linkedin")
        linkedin_link = href
       elsif href.include?("github")
        github_link = href
      else
        blog_link = href
      end
     end
     bio = profile_data.css(".details-container .description-holder p").text
     profile_quote = profile_data.css(".vitals-text-container .profile-quote").text
     student_profile_hash = {:twitter=>twitter_link,
               :linkedin=>linkedin_link,
               :github=>github_link,
               :profile_quote=>profile_quote,
               :blog=>blog_link,
               :bio=> bio}
               student_profile_hash.delete_if {|key, value| value == "" || value == nil}
    student_profile_hash
   
  end

end

