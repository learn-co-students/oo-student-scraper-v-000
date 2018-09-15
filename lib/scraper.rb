require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      students << {:name => student.css(".card-text-container .student-name").text,
                   :location => student.css(".card-text-container .student-location").text,
                   :profile_url => student.children.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile = {}

    #Iterate through social icons to grab social links and add to profile hash
    doc.css(".main-wrapper .vitals-container .social-icon-container").children.css("a").each do |link|
      social_profile_name = link.css("img").attribute("src").value.split("/")[-1].split("-")[0]
      social_profile_name = "blog" if social_profile_name == "rss"
      social_profile_link = link.attribute("href").value
      profile[social_profile_name.to_sym] = social_profile_link
    end

    #add profile quote to hash
    profile[:profile_quote] = doc.css(".main-wrapper .vitals-container .vitals-text-container .profile-quote").text

    #add bio to hash
    profile[:bio] = doc.css(".main-wrapper .details-container .bio-block .bio-content .description-holder p").text

    #return hash
    profile
  end

end
