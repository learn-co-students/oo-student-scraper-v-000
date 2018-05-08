require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    new_array=[]
    doc = Nokogiri::HTML(open(index_url))
   students = doc.css(".roster-cards-container .student-card")

    students.collect do |student|
    new_array << {:name => student.css("h4").text, :location => student.css(".student-location").text, :profile_url =>   student.css("a").attribute("href").text}
    end
    new_array
  end


  def self.scrape_profile_page(profile_url)
    prof = {}
    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css(".profile")
    doc.css(".social-icon-container a").each do |p2|

     #prof_url = p2.attribute("href")
    prof[:twitter] = p2.attribute("href").text if p2.attribute("href").text.include?("twitter")
    prof[:linkedin] = p2.attribute("href").text if p2.attribute("href").text.include?("linkedin")
    prof[:github] = p2.attribute("href").text if p2.attribute("href").text.include?("github")
    prof[:blog] = p2.attribute("href").text if p2.css("img").attribute("src").text.include?("rss")
    #prof[:linkedin] = p2.css("a").attribute("href").text if p2.css("a").attribute("href").text.include?("linkedin")
end
  prof[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text
  prof[:bio] = profile.css(".details-container .bio-block .description-holder p").text
   prof

end



end
