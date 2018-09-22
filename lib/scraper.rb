require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html(index_url).css(".student-card").map do |student|
      {
        name: student.css('.student-name').text,
        location: student.css('.student-location').text,
        profile_url: student.css('a').attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    @student_profile = html(profile_url).css(".profile")
    twitter = get_social("twitter")
    linkedin = get_social("linkedin")
    github = get_social("github")
    blog = get_social("rss")

    student_profile_hash =
    {
      profile_quote: @student_profile.css(".profile-quote").text,
      bio: @student_profile.css(".bio-content p").text
    }
    student_profile_hash[:twitter] = twitter unless twitter.nil?
    student_profile_hash[:linkedin] = linkedin unless linkedin.nil?
    student_profile_hash[:github] = github unless github.nil?
    student_profile_hash[:blog] = blog unless blog.nil?
    student_profile_hash
  end

  def self.html(url)
    Nokogiri::HTML(open(url))
  end

  def self.get_social(platform)
    rule = Regexp.new(platform,'i')
    handle = @student_profile.css(".social-icon-container a").find { |s| rule.match(s.css('.social-icon').attribute("src").value)}
    if !handle.nil?
      handle.attribute("href").value
    end
  end
end
