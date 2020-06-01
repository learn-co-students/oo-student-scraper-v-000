require 'open-uri'
require 'pry'

class Scraper

  # s[:name] = scraped_students.css("h4.student-name").text
  # s[:location] = scraped_students.css("p.student-location").text
  # s[:profile_url] = scraped_students.css(".student-card a").attribute("href").value

  def self.scrape_index_page(index_url)
    scrape = Nokogiri::HTML(open("#{index_url}"))
    scraped_students = []

    scrape.css("div.roster-cards-container").each do |card|
      scrape.css(".student-card").each do |s|
        student = {
          :name => s.css("h4.student-name").text,
          :location => s.css("p.student-location").text,
          :profile_url => s.css("a").attribute('href').value
          }

        scraped_students << student
      end
    end
    scraped_students
  end

  # profile => ("div.main-wrapper.profile").collect
  # profile_quote => ("div.profile-quote").text
  # bio => ("div.bio-content.content-holder div.description-holder p").text
  # social_media => ("div.social-icon-container")
  # twitter => ("div.social-icon-container a").attribute('href').value

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open("#{profile_url}"))
    @scraped_profile = {}

    profile.css("div.main-wrapper.profile").each do |p|
      # scraped_student = {
      #   :profile_quote => profile.css("div.profile-quote").text,
      #   :bio => profile.css("div.bio-content.content-holder div.description-holder p").text,
      #
      # }
      @scraped_profile[:profile_quote] = profile.css("div.profile-quote").text
      @scraped_profile[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text

      social_media = profile.css("div.social-icon-container a").collect do |social_link|
          social_link.attribute('href').value
      end

      social_media.each do |social_link|
        case social_link
        when /twitter/
          @scraped_profile[:twitter] = social_link
        when /linkedin/
          @scraped_profile[:linkedin] = social_link
        when /github/
          @scraped_profile[:github] = social_link
        else
          @scraped_profile[:blog] = social_link
        end
      end
    end

    @scraped_profile # => hash in which the k/v pairs describe an individual student
  end

end
