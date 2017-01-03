require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn = Nokogiri::HTML(open(index_url))

    scraper_array = []

    learn.css(".student-card").each do |elements|

      hash = {}
       hash[:name] = elements.css(".student-name").text
       hash[:location] = elements.css(".student-location").text
       hash[:profile_url] = "./fixtures/student-site/" + elements.css('a[href]').map{|link| link['href']}.join

       scraper_array << hash
    end
      scraper_array
    end


  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
        url_hash = {}

          doc.css(".main-wrapper").detect do |each_profile|

            url = each_profile.css(".social-icon-container").css('a[href]').map{|link| link['href']}
              url.each do |each_link|
                  if each_link.include?("twitter")
                    url_hash[:twitter] = each_link

                  elsif
                    each_link.include?("linkedin")
                      url_hash[:linkedin] = each_link

                    elsif
                      each_link.include?("github")
                        url_hash[:github] = each_link
                      else
                        url_hash[:blog] = each_link
                  end
              end

             url_hash[:profile_quote] = each_profile.css(".vitals-text-container").css(".profile-quote").text
             url_hash[:bio] = each_profile.css(".description-holder").css("p").text

         end
      url_hash
  end

end


Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/index.html")
