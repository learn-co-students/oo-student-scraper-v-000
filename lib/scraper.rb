require 'open-uri'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card").each do |student|
      student_hash = {
        :name => student.css(".student-name").first.text,
        :location => student.css(".student-location").first.text,
        :profile_url => "http://127.0.0.1:4000/" + student.css("a").first.first[1]
      }
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    doc.css(".profile .vitals-container .social-icon-container a").each do |link| #generate the social keys
      links = link.first[1]
      if links.match(/(linkedin|twitter|github)/) #if a social link URL has one of these in the URL
        match = links.match(/(linkedin|twitter|github)/)[1] #grab the match phrase
        profile_hash[match.to_sym] = link.first[1] #set the key equal to match and set the value equal to the URL
      else #do this if there are no matches above - checking to see if they have a blog link
        profile_hash[:blog] = link.first[1]
      end
    end
    profile_hash[:profile_quote] = doc.css(".profile .vitals-container .vitals-text-container .profile-quote").text
    profile_hash[:bio] = doc.css(".profile .details-container .description-holder p").text
    profile_hash
  end

end

 