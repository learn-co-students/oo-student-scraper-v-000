require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    page = Nokogiri::HTML(open(index_url))
    students = []
    students_hash = {}
    student = page.css("div.student-card").each do |student|
       students_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << students_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
      info = {}
      page.css(".social-icon-container a").each do |x|
        if x.attribute("href").value.include?("twitter")
          info[:twitter] = x.attribute("href").value
        elsif x.attribute("href").value.include?("linkedin")
          info[:linkedin] = x.attribute("href").value
        elsif x.attribute("href").value.include?("github")
          info[:github] = x.attribute("href").value
        else
          info[:blog] = x.attribute("href").value
       end
      end
      info[:profile_quote] = page.css(".profile-quote").text
      info[:bio] = page.css(".bio-content .description-holder p").text
   info
     end

end
