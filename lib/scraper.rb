require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    scraped_students = doc.css(".student-card").collect do |x|
      {name: x.css(".student-name").first.text,
      location: x.css(".student-location").first.text,
      profile_url: "./fixtures/student-site/#{x.css('a').first.values[0]}"}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = doc.css('.main-wrapper').first
    socials = profile.css('.social-icon-container a')

    twitter = socials.find{|x| x['href'].include?("twitter")}
    linkedin = socials.find{|x| x['href'].include?("linkedin")}
    github = socials.find{|x| x['href'].include?("github")}
    blog = socials[3]

    scraped_student = {
      twitter: twitter && twitter.values[0],
      linkedin: linkedin && linkedin.values[0],
      github: github && github.values[0],
      blog: blog && blog.values[0],
      profile_quote: profile.css('.profile-quote').text,
      bio: profile.css('.bio-content p').text
    }

    scraped_student.each do |x, y|
      if y == nil
        scraped_student.delete(x)
      end
    end

  end

end
