require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_cards = index_page.css(".student-card")
    student_data = []
    student_cards.each_with_index do |student_card, index|
      student_data[index] = {
        :name => student_card.at_css('.student-name').inner_html,
        :location => student_card.at_css('.student-location').inner_html,
        :profile_url => student_card.at_css("a").attributes['href'].value
      }
    end
    student_data
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_data = {}

    # Extract the social links when available
    twitter_url, linkedin_url, github_url, blog_url = nil, nil, nil, nil

    social_links = profile_page.css('.social-icon-container a')
    social_links.each do |link|
      link_icon_filename = link.at('img').attributes['src'].value

      if link_icon_filename.include?('twitter-icon')
        twitter_url = link.attributes['href'].value
      elsif link_icon_filename.include?('linkedin-icon')
        linkedin_url = link.attributes['href'].value
      elsif link_icon_filename.include?('github-icon')
        github_url = link.attributes['href'].value
      elsif link_icon_filename.include?('rss-icon')
        blog_url = link.attributes['href'].value
      end
    end

    student_data[:twitter] = twitter_url if twitter_url
    student_data[:linkedin] = linkedin_url if linkedin_url
    student_data[:github] = github_url if github_url
    student_data[:blog] = blog_url if blog_url

    # Extract the profile quote and bio
    student_data[:profile_quote] = profile_page.at('.profile-quote').inner_html
    student_data[:bio] = profile_page.at('.bio-content .description-holder p').inner_html

    student_data

  end
end

