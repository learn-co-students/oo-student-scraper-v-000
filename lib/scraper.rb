require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML (open(index_url))
    student = []
  index.css(".student-card").each do |students|
    name = students.css(".student-name").text
    location = students.css(".student-location").text
    profile_url = "./fixtures/student-site/#{students.css("a").attr('href').text}"

    student << {name: name, location: location, profile_url: profile_url}
    end
    #binding.pry
    student
  end

  def self.scrape_profile_page(profile_url)
    index_page =  Nokogiri::HTML(open(profile_url))
    students = {}
    index_page.css(".social-icon-container a").each do |links|
      if links.attr("href").include?("linkedin")
        students[:linkedin] = links.attr("href")
      elsif links.attr("href").include?("github")
        students[:github] = links.attr("href")
      elsif links.attr("href").include?("twitter")
        students[:twitter] =links.attr("href")
      else links.attr("href").include? ("blog")
        students[:blog] = links.attr("href")
      end
    end
    students[:profile_quote] = index_page.css(".vitals-container .vitals-text-container .profile-quote").text
    students[:bio] = index_page.css(".details-container .bio-block .description-holder p").text
    students
end

end
