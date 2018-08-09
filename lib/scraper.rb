require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    htmlcode= Nokogiri::HTML(open(index_url))

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
    htmlcode= Nokogiri::HTML(open(profile_url))
    sm= []
    quote = ' '
    bio = ' '
    tw,ink,gt,bl = ' '


              htmlcode.css(".social-icon-container a").each { |val|
                sm << val.attribute('href').value
              }
              sm.each {|s|

                 if s.include?("twitter.com")
                   tw = s
                 end
                 if s.include?("linkedin.com")
                   ink = s
                 end
                 if s.include?("github.com")
                   gt = s
                 end
                 if !s.include?("twitter.com") && !s.include?("github.com") && !s.include?("linkedin.com")
                   bl = s
                 end

               }

            quote =  htmlcode.css('.vitals-text-container .profile-quote').text

            bio  = htmlcode.css('div.bio-block p').text


            hash = {
                      :twitter =>  tw,
                      :linkedin => ink,
                      :github=>  gt,
                      :blog=> bl,
                      :profile_quote => quote,
                      :bio=>    bio          }.reject {|k,v| v == " "   }

             return hash

     end

end
