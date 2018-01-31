require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    file = File.open(index_url)
    html = Nokogiri::HTML(file)
    html.css(".student-card").collect do |card|
      #binding.pry
      {
      :name => card.css("h4").text,
      :location => card.css("p").text,
      :profile_url => card.css("a").first["href"]
    }
    end
  end

  def self.scrape_profile_page(profile_url)
    file = File.open(profile_url)
    html = Nokogiri::HTML(file)
    profile_hash = Hash.new
      html.css(".social-icon-container a").each do |site|
        new_key = site["href"].scan(/\w{6,}/)
        new_key[0] = "blog" unless new_key[0] == "twitter" || new_key[0] == "linkedin" || new_key[0] == "github"
        profile_hash[new_key[0].to_sym] = site["href"]
      end
     profile_hash[:profile_quote] = html.css(".profile-quote").text
     profile_hash[:bio] = html.css(".bio-content .description-holder p").text
     profile_hash
  end

end
