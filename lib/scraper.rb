require 'open-uri'
require 'pry'

class Scraper
 # profiles : doc.css("div.student-card")
 # profile_url: profile.css("a").attribute("href").value
 #name: profile.css("h4.student-name").text
 #location: profile.css("p.student-location").text
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles_index = []
    student = {}
      doc.css("div.student-card").each do |profile|
        student = {
          :name => profile.css("h4.student-name").text,
          :location => profile.css("p.student-location").text,
          :profile_url => profile.css("a").attribute("href").value
         }
      profiles_index << student
    end
    profiles_index
  end
# page: doc.css("div.main-wrapper.profile")
# links: page.css("div.social-icon-container a").attribute("href").value
# profile_quote: page.css("div.profile-quote").text
# bio: page.css("div.bio-content.content-holder div.description-holder p").text

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
     profile = {}
     doc.css("div.main-wrapper.profile").each do |page|
       urls = []
       page.css("div.social-icon-container a").each do |link|
          urls << link.attribute("href").value
        end
        urls
          urls.each do |url|
          if url.include?("twitter")
            profile[:twitter] = url
          elsif url.include?("linkedin")
            profile[:linkedin] = url
          elsif url.include?("github")
            profile[:github] = url
          else
            profile[:blog] = url
         end
       end
        profile[:profile_quote] = page.css("div.profile-quote").text
        profile[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text
      end
      profile
  end
end
