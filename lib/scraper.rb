require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = File.read(index_url)
    doc = Nokogiri::HTML(index_url)

    students_array = []

      doc.css("div.student-card").each do |student|
        students_array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
        }
      end

    students_array

  end

  def self.scrape_profile_page(profile_url)
    profile_url = File.read(profile_url)
    doc = Nokogiri::HTML(profile_url)

    profile_hash = {}

   social = doc.css(".social-icon-container a").collect {|link| link['href']}
   github_value = social.grep(/github/).join
   twitter_value = social.grep(/twitter/).join
   linkedin_value = social.grep(/linkedin/).join
   if social.last != github_value && social.last != twitter_value && social.last != linkedin_value
     blog_value = social.last
   end
   profile_quote_value = doc.css(".profile-quote").text
   bio_value = doc.css(".bio-content .description-holder p").text

    profile_hash = {
      :twitter => twitter_value,
      :linkedin => linkedin_value,
      :github => github_value,
      :blog => blog_value,
      :profile_quote => profile_quote_value,
      :bio => bio_value
    }

    profile_hash.delete_if {|k, v| v == "" || v == nil}
    profile_hash

  end

end
