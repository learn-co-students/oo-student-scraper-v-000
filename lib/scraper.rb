require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_index = Nokogiri::HTML(open(index_url))

    learn_index.css("div.student-card").map do |student_card|
      {
        :name => student_card.css("a div.card-text-container h4.student-name").text,
        :location => student_card.css("a div.card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/#{student_card.css("a").attribute("href").value}"
      }
    end

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    # Profile Page - Nokogiri XML Object
    profile = profile_page.css("div.main-wrapper.profile")

    # Social Links
    twitter_url = ""
    linkedin_url = ""
    github_url = ""
    blog_url = ""

    social_links = profile.css("div.vitals-container div.social-icon-container a").map{|social_link| social_link.attribute("href").value}
    social_links.each do |link|
      if link.include?("twitter")
        twitter_url = link
      elsif link.include?("github")
        github_url = link
      elsif link.include?("linkedin")
        linkedin_url = link
      else
        # all blog URLs are different
        blog_url = link
      end
    end

    # Profile Quote
    profile_quote = profile.css("div.vitals-container div.vitals-text-container div.profile-quote").text

    # Bio
    bio_text = profile.css("div.description-holder p").text

    profile = {
      :twitter => twitter_url,
      :linkedin => linkedin_url,
      :github => github_url,
      :blog => blog_url,
      :profile_quote => profile_quote,
      :bio => bio_text
    }

    profile.delete_if {|k, v| v == ""}
    profile

  end

end
