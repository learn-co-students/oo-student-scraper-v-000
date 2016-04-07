require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #the first student's info is:
    #name: doc.css(".student-card").first.css(".student-name").text
    #location: doc.css(".student-card").first.css(".student-location").text
    #url: doc.css(".student-card a").first.attribute("href").value
    doc.css(".student-card").collect do |student|
        {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => index_url + student.css("a").attribute("href").value
         }
     end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #The return value of this method should be a hash in which the key/value pairs describe an individual 
    #student. Some students don't have a twitter or some other social link. 
    profile = {}
    #iterate through social-icon-container class to input social links if they exist
    #twitter = doc.css(".social-icon-container a").first.attribute("href").value
    doc.css(".social-icon-container a").each do |info| 
  
      image = info.css("img").attribute("src").value

        if image[/twitter/]
          profile[:twitter] = info.attribute("href").value
        elsif image[/linkedin/]
          profile[:linkedin] = info.attribute("href").value
        elsif image[/github/]
          profile[:github] = info.attribute("href").value
        elsif image[/rss/]
          profile[:blog] = info.attribute("href").value
        end
      end

      profile[:profile_quote] = doc.css(".profile-quote").text.strip
      profile[:bio] = doc.css(".description-holder p").text.strip

      profile
  end

end


