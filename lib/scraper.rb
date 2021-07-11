require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    index_page.css(".student-card").collect do |student|
       {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
       }
    end
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    profile_details = {}

    social_link_tags = profile_page.css(".social-icon-container").css("a")


    social_link_tags.each do |social_link_tag|
      social_site_url = social_link_tag.attr("href") # here is the url
      social_site_name = social_site_url.match(/\/\/[w]{3}?\.?(\w+).com/).captures[0] # site name

      if ['github', 'linkedin', 'twitter'].include?(social_site_name)
        profile_details[social_site_name.to_sym] = social_site_url

      else
        profile_details[:blog] = social_site_url
      end

    end

    profile_details[:profile_quote] = profile_page.css(".profile-quote").text
    profile_details[:bio] = profile_page.css(".bio-block").css("p").text

    return profile_details

  end

end

Scraper.scrape_profile_page('./fixtures/student-site/students/david-kim.html')
