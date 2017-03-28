require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_students = Nokogiri::HTML(open(index_url))
    learn_students.css("div.student-card").map do |e|
     {:name => e.css("h4.student-name").first.text,
      :location => e.css("p.student-location").first.text,
      :profile_url => File.join("./fixtures/student-site/", e.css("a").first['href'])
    }
    end
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    link_hash = {}
    student_profile = Nokogiri::HTML(open(profile_url))

    student_profile.css("div.main-wrapper").each do |e|
      student_hash = {
        :profile_quote => e.css("div.profile-quote").first.text,
        :bio => e.css("div.description-holder p").first.text,
        :twitter => e.css(".social-icon-container a").map {|link| link["href"] if link["href"].include? "twitter"}.compact.join,
        :linkedin => e.css(".social-icon-container a").map {|link| link["href"] if link["href"].include? "linkedin"}.compact.join,
        :github => e.css(".social-icon-container a").map {|link| link["href"] if link["href"].include? "github"}.compact.join,
        :blog => e.css(".social-icon-container a").map.with_index do |link, index| 
          link["href"] unless link["href"].include?("github") ||
          link["href"].include?("twitter") ||
          link["href"].include?("linkedin")
        end.compact.join
      }
    end
    student_hash.delete_if { |k, v| v.empty? }
  end

end




# student name: doc.css("h4.student-name").first.text
# student location: doc.css("p.student-location").first.text
# get_link = doc.css("div.roster-cards-container  a")
# get_link.map {|e| e["href"]}
# get_link = doc.css("div.roster-cards-container  a")
# get_link.first['href']
