require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

   index = []
   doc.css("div.student-card").each do |student|
     index << {
       name: student.css("h4.student-name").text,
       location: student.css("p.student-location").text,
       profile_url: index_url + student.css("a").attribute("href").value
     }
end
index
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}
    doc.css("div.social-icon-container a").each do |mad|
 p_url = mad.attribute("href").value
    if p_url.include?("twitter")
      profile[:twitter] = p_url
    elsif p_url.include?("linkedin")
 profile[:linkedin] = p_url
 elsif p_url.include?("github")
   profile[:github] = p_url
 else
profile[:blog] = p_url
end
p_quote = doc.css("div.profile-quote").text
bio_p = doc.css("div.description-holder p").text

profile[:profile_quote] = p_quote
profile[:bio] = bio_p

end
profile
end

end
