require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    # make document
    index_saw = Nokogiri::HTML(open(index_url))
    # make names array
    name_array = index_saw.css(".student-card .student-name").map {|nom| {:name => nom.text}}
    # make locations array
    location_array = index_saw.css(".student-card .student-location").map {|loc| {:location => loc.text}}
    # make_url_array
    url_array = index_saw.css(".student-card a").xpath('@href').map {|uri| {:profile_url => uri.text}}
    # merge elements
    student_array = name_array.each_with_index { |hsh, ind| hsh.merge!(location_array[ind]).merge!(url_array[ind])}
    # return student array
    student_array

  end


  def self.get_url_by_icon(sitename, doc)
    # find social link generically by icon;
    # parsing url for keyword doesn't find blogs
    doc.xpath("//img[contains(@src, '#{sitename}')]/../@href").text
  end

  def self.scrape_profile_page(profile_url)
    # make document
    profile_saw = Nokogiri::HTML(open(profile_url))
    # keywords to parse urls
    site_array = ["twitter", "linkedin", "github", "rss"]
    # empty placeholder hash
    student_hash = {}

    site_array.each do |site|
      # check for social links' presence
      if get_url_by_icon("#{site}", profile_saw).length > 0
      # update student_hash with found links
        student_hash.merge!({site.to_sym => get_url_by_icon("#{site}", profile_saw) })
      end
    end

    # the word blog isn't in the profile page. rename it from search term rss
    student_hash[:blog] = student_hash.delete(:rss) if student_hash.has_key?(:rss)

    # easily scrape quote and bio
    student_hash.merge!({:profile_quote => profile_saw.css(".profile-quote").text })
    student_hash.merge!({:bio => profile_saw.css(".bio-content p").text })

    #return filled-out hash
    student_hash



  end

end
