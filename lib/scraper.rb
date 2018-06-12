require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  index_url = "./fixtures/student-site/index.html"


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_card = doc.css(".student_card")
    students = []
    student_card.collect do |student_card_xml|
      students << {
      :name => student_card_xml.css("h4.student-name").text,
      :location => student_card_xml.css("p.student-location").text,
      :profile_url => "./fixtures/student-site/" + student_card_xml.css("a").attribute("href").value
    }
    end
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
     profile_html = open(profile_url)
     profile_doc = Nokogiri::HTML(profile_html)
     attributes = {}
     profile_doc.css("div.social-icon-container a").each do |link_xml|
       case link_xml.attribute("href").value
       when /twitter/
         attributes[:twitter] = link_xml.attribute("href").value
       when /github/
         attributes[:github] = link_xml.attribute("href").value
       when /linkedin/
         attributes[:linkedin] = link_xml.attribute("href").value
       else
         attributes[:blog] = link_xml.attribute("href").value
       end
     end
     attributes[:profile_quote] = profile_doc.css("div.profile-quote").text
     attributes[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
     attributes
    end


  end
