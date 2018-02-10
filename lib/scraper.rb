require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # OUTPUT: {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css("div.student-card").each do |student|
      student_hash = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a")[0]["href"]
      }
      students << student_hash
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      profile_hash = {}
      # iterate over the social icons to add them in the hash with the correct key:
      doc.css("div.social-icon-container a").each do |link|
        if link['href'].include? "twitter"
          profile_hash[:twitter] = link['href']
        elsif link['href'].include? "linkedin"
            profile_hash[:linkedin] = link['href']
        elsif link['href'].include? "github"
            profile_hash[:github] = link['href']
          else
            profile_hash[:blog] = link['href']
          end
        end
        # then add quote and bio:
        profile_hash[:profile_quote] = doc.css("div.profile-quote").text
        profile_hash[:bio] = doc.css("div.description-holder p").text
        # return the final hash:
        profile_hash
  end

end
