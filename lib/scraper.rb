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
    profile = Nokogiri::HTML(open(profile_url))
    social_hash={}

    # save all the hrefs in a variable to use later. .map saves an entirely new array with the hrefs
    href_links = profile.css(".social-icon-container a").map { |url| url['href'] }

    # cycle through each href and match them to the relative link
    href_links.each do |href_link|
      if href_link.include?("twitter")
        social_hash[:twitter] = href_link

      elsif href_link.include?("linkedin")
        social_hash[:linkedin] = href_link

      elsif href_link.include?("github")
        social_hash[:github] = href_link

      else social_hash[:blog] = href_link
      end
    end # end of each enumurable
    
    # if there are no bios or quotes then these will return as empty strings.
    social_hash[:bio] = profile.css("p").text
    social_hash[:profile_quote] = profile.css(".profile-quote").text
    social_hash
    end

end
