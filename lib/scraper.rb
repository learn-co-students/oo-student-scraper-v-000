require 'open-uri'
require 'nokogiri' # I added this
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # stores the HTML of the URL into a variable called html
    # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(open(index_url))
   # selector will allow us to grab index page that lists all of the students
    student_profile=[]
    hash={}
    index = doc.css(".roster-cards-container").each do |student|
      student.css(".student-card a").each do |student_detail|
         hash={name: student_detail.css("h4.student-name").text,
               location: student_detail.css("p.student-location").text,
               profile_url: "./fixtures/student-site/#{student_detail['href']}"}
              # binding.pry
         student_profile << hash
      end
    end
    student_profile
  end

  def self.scrape_profile_page(profile_url)
    # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(open(profile_url))
    student_profile=[]
    social_hash={}

    doc.css(".main-wrapper profile").each do |social|

      social.css(".social-icon-container").detect do |url|
        if url.include?( "twitter")
          social_hash[:twitter] = "#{url['href']}"

        elsif url.include?("linkedin")
          social_hash[:linkedin] = "#{url['href']}"

        elsif url.include?("github")
          social_hash[:github] = "#{url['href']}"

        else social_hash[:blog] = "#{url['href']}"

        end
      end # end of second enumurable

      social_hash[:bio] = social.css("p")
      social_hash[:profile_quote] = social.css(".profile-quote")
      binding.pry

    end # end of first enumerable
    social_hash
  end

end
