require 'open-uri'
require 'pry'
# QUESTion I'm still not clear why these are built as class methods?
class Scraper
  def message
    puts "hello"
  end

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    card = doc.css(".student-card")
    student_hashes = []

    card.map do |c|
      student = {}
      student[:name] = "#{c.css("h4").text}"
      student[:location] = "#{c.css(".student-location").text}"
      student[:profile_url] = "#{c.css("a")[0]["href"]}"
      student_hashes << student
    end
    student_hashes
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}


     ## commented code /// left side turns the site name between "www." & ".com" into a symbol of the profile hash
     #  ie www.twitter.com becomes profile_hash[:twitter]
     #  ride side of equals sign assigns the full href to that symbol.

#    doc.css(".social-icon-container a").each do |x|
#      profile_hash["#{x.to_s.scan(/www\.\w*/)[0].to_s.gsub("www.", "")}".to_sym] = x.attribute("href").value
#    end

    test_return = doc.css(".social-icon-container a").each do |a|
       case  a.attribute("href").value
       when /linkedin/
         profile_hash[:linkedin] =  a.attribute("href").value
       when /github/
         profile_hash[:github] =  a.attribute("href").value
       when /twitter/
         profile_hash[:twitter] =  a.attribute("href").value
       else
         profile_hash[:blog] = a.attribute("href").value
       end
     end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text

    profile_hash
  end

end
