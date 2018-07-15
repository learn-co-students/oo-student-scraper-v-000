require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css('.student-card')
    cards.map do |card|
      {
        name: card.css('.student-name').text,
        location: card.css('.student-location').text,
        profile_url: index_url.chomp('index.html') + card.css('a').first['href']
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = doc.css('.main-wrapper').first
    socials = profile.css('.social-icon-container a')

    twitter = socials.detect{ |a| a['href'].match(/twitter\.com/i) }
    linkedin = socials.detect{ |a| a['href'].match(/linkedin\.com/i) }
    github = socials.detect{ |a| a['href'].match(/github\.com/i) }
    blog = socials.detect{ |a| a.css('img').first['src'].match(/rss\-icon/) }

    student = {
      twitter: twitter && twitter['href'],
      linkedin: linkedin && linkedin['href'],
      github: github && github['href'],
      blog: blog && blog['href'],
      profile_quote: profile.css('.profile-quote').text,
      bio: profile.css('.bio-content .description-holder p').text
    }

    student.delete_if { |k, v| v.nil? }
  end
end
