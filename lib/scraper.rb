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

    student = {}

    # Profile Page - Nokogiri XML Object
    profile = profile_page.css("div.main-wrapper.profile")

    social_links = profile.css("div.vitals-container div.social-icon-container a").map{|social_link| social_link.attribute("href").value}
    social_links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      else
        # all blog URLs are different
        student[:blog] = link
      end
    end

    # Profile Quote
    student[:profile_quote] = profile.css("div.profile-quote").text

    # Bio
    student[:bio] = profile.css("div.description-holder p").text

    student.delete_if {|k, v| v == ""}
    student

  end

end
