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
    # :twitter>, :linkedin, :github, :blog, :profile_quote, :bio
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)

    social_link_tags = profile_page.css(".social-icon-container").css("a")

    profile_details = {
      :twitter => social_link_tags[0].attr("href"),
      :linkedin => social_link_tags[1].attr("href"),
      :github => social_link_tags[2].attr("href"),
      :profile_quote => profile_page.css(".profile-quote").text,
      :bio => profile_page.css(".bio-block").css("p").text
    }

    # i want to do something clean for this. Dynamically add
    # symbols for the social links if they exist
    # if social_link_tags[3].attr("href")
    #   profile_details[:blog] = social_link_tags[3].attr("href")
    # end
  end

end
