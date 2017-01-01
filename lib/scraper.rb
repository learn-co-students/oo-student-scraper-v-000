require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn = Nokogiri::HTML(html)

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
          # binding.pry
          if each_link == url[0]
            url_hash[:twitter] = url[0]
            elsif
              each_link == url[1]
                url_hash[:linkedin] = url[1]
              elsif
                each_link == url[2]
                  url_hash[:github] = url[2]
                elsif
                  each_link == url[3]
                    url_hash[:blog] = url[3]
          end
        end


            #  url_hash[:twitter] = each_profile.css(".social-icon-container").css('a[href]').map{|link| link['href']}[0]
            #  url_hash[:linkedin] = each_profile.css(".social-icon-container").css('a[href]').map{|link| link['href']}[1]
            #  url_hash[:github] = each_profile.css(".social-icon-container").css('a[href]').map{|link| link['href']}[2]
            #  url_hash[:blog] =  each_profile.css(".social-icon-container").css('a[href]').map{|link| link['href']}[3]

             url_hash[:profile_quote] = each_profile.css(".vitals-text-container").css(".profile-quote").text
             url_hash[:bio] = each_profile.css(".description-holder").css("p").text

         end
      url_hash
  end



end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/index.html")
