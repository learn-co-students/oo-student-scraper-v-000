require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []
    doc.css("div.student-card").each do |student|
      students << student_hash = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css("a").attr("href").text
    }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    #create array of links
    profile_links = profile.css("div.social-icon-container a").collect do |link|
      link.attr("href")
    end
    #find link that contains keyword
    profile_hash = {
      :twitter => profile_links.detect{|link| link.include?('twitter')},
      :linkedin => profile_links.detect{|link| link.include?('linkedin')},
      :github => profile_links.detect{|link| link.include?('github')},
      :blog => profile_links.detect{|link| !link.include?('twitter') && !link.include?('linkedin') && !link.include?('github')},
      :profile_quote => profile.css("div.profile-quote").text,
      :bio => profile.css("div.bio-content p").text
    }
    profile_hash.delete_if{|k,v| v.nil?}
    #removing empty elements from hash
    #https://stackoverflow.com/questions/3450641/removing-all-empty-elements-from-a-hash-yaml
  end

end
