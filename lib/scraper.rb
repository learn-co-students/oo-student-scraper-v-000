require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    x = doc.css(".student-name")
    y = doc.css(".student-location")
    z = doc.css(".student-card a")
    q = []
    z.each do |url|
      q << url["href"]
    end
    counter = 0
    counter2 = 0
    counter3 = 0
    counter4 = 0
    t = []
     while counter4 < x.length
       t[counter4] = {}
       counter4 += 1
     end
     while counter < x.length
       t[counter][:name] = x[counter].text
       counter += 1
     end
     while counter2 < y.length
       t[counter2][:location] = y[counter2].text
       counter2 += 1
     end
     while counter3 < q.length
       t[counter3][:profile_url] = q[counter3]
       counter3 += 1
     end
     return t
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    x = doc.css(".social-icon-container a")
    a = {}
    counter = 0
    x.each do |icon|
      if icon["href"].include?("twitter")
        a[:twitter] = icon["href"]
      elsif icon["href"].include?("linkedin")
        a[:linkedin] = icon["href"]
      elsif icon["href"].include?("github")
        a[:github] = icon["href"]
      else
        a[:blog] = icon["href"]
      end
    end
    y = doc.css(".profile-quote").text
    if y != nil
      a[:profile_quote] = y
    end
    z = doc.css(".bio-content p").text
    a[:bio] = z
    return a
  end

end
