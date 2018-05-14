require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    roster = []

    names = doc.css(".student-name").collect {|v| v.text}
    location = doc.css(".student-location").collect {|v| v.text}
    profile_url = doc.css("div.student-card a").collect {|v| v['href']}

    i = 0
    while i < names.size
      roster << {:name => names[i], :location => location[i], :profile_url => profile_url[i]}
      i+=1
    end

    roster
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}

    doc.css("a").each do |v|
      if v['href'].include?("twitter")
        profile[:twitter] = v['href']
      elsif v['href'].include?("linkedin")
        profile[:linkedin] = v['href']
      elsif v['href'].include?("github")
        profile[:github] = v['href']
      elsif v['href'] != "../"
        profile[:blog] = v['href']
      end
    end


    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css("p").text

    profile
  end

end
