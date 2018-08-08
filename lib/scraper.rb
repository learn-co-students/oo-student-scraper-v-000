require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    htmlcode= Nokogiri::HTML(html)
    profiles= []
    htmlcode.css('.student-card').each { |dat|

                    hash = {  :name => dat.css("h4").text,
                              :location => dat.css("p").text,
                              :profile_url => dat.css('a').attribute('href').value   }

                    profiles.push(hash)
    }
    return profiles
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    htmlcode= Nokogiri::HTML(html)
    profile_url= []

    #get all the values
    htmlcode.css('.profile').each { |dat|
                       twitter = ' '
                       ink = ' '
                       gith = ' '
                       blog = ' '

                   #get social status
                      dat.css(".vitals-container .social-icon-container").each { |chr|
                              # puts chr.css("a").attribute("href").value

                              if chr.css("a").attribute("href").value.include?("twitter.com")
                                 twitter = chr.css("a").attribute("href").value
                              end
                              if chr.css("a").attribute("href").value.include?("linkedin.com")
                                 ink = chr.css("a").attribute("href").value
                              end
                              if chr.css("a").attribute("href").value.include?("github.com")
                                gith = chr.css("a").attribute("href").value
                              end
                              if !chr.css("a").attribute("href").value.include?("twitter.com") &&  !chr.css("a").attribute("href").value.include?("linkedin.com") && !chr.css("a").attribute("href").value.include?("github.com")
                                blog = chr.css("a").attribute("href").value
                              end
                          }



          hash = {
                    :twitter =>  twitter,
                    :linkedin => ink,
                    :github=>  gith,
                    :blog=> blog,

                    :profile_quote => " p",
                    :bio=>    "p "          }
          hash.delete_if{|k,v| v.nil? }

                 binding.pry
         return hash


        }#get all the values
  end

end
