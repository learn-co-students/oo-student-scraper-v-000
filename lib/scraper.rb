require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    # name = doc.css(".student-card").first.css(".card-text-container").first.css(".student-name").text
    # location = doc.css(".student-card").first.css(".card-text-container").first.css(".student-location").text
    # profile_url = doc.css(".student-card").css("a").first["href"]

    doc.css(".student-card").collect do |student|
      {
        :name => student.css(".card-text-container").css(".student-name").text,
        :location => student.css(".card-text-container").css(".student-location").text,
        :profile_url => student.css("a").first["href"]
      }
    end

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    hashes_array = []
    doc.css(".vitals-container").css(".social-icon-container").css("a").each do |icon|

      icon.each do|weblink|

        key = ""

        if weblink[1].match(/twitter/)
          key = "twitter"
          key = key.to_sym

        elsif weblink[1].match(/github/)
          key = "github"
          key = key.to_sym

        elsif weblink[1].match(/linkedin/)
          key = "linkedin"
          key = key.to_sym

        else
          key = "blog"
          key = key.to_sym
        end
        hashes_array << {key => weblink[1]}
      end
    end
    # profile quote
    quote = doc.css(".vitals-container").css(".vitals-text-container").css(".profile-quote").text
    hashes_array << {:profile_quote => quote}

    # bio
    biography = doc.css(".details-container").css(".details-block").
    css(".content-holder").css(".description-holder").css("p").text
    hashes_array << {:bio => biography}

    # merges all hashes together
    # reduce/inject are the same
    # a is the accumulator
    # on first iteration "a" is twitter and "b" is twitter, v1(oldvalue),v2(newvalue)
    # v1 and v2 are compared and if returns truthy return v1(twitter) to accumulator
    # on second iteration "a" is twitter and b is github, they are not equal so place v1 and v2 in array and flatten
    # return the flatten values
    hashes_array.reduce do |a,b|
      a.merge(b) {|k,v1,v2| v1 == v2 ? v1 : [v1,v2].flatten}
    end


  end

end
