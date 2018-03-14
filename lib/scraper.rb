require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css('.roster-cards-container .student-card')
    student_array = []

    student_cards.each do |student|
      student_info = Hash.new
      student_info[:name] = student.css('.student-name').text
      student_info[:location] = student.css('.student-location').text
      student_info[:profile_url] = student.css('a').attribute("href").value
      #"./fixtures/student-site/" +

      student_array << student_info
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = doc.css('.main-wrapper')
    profile = Hash.new

    social_links = student_profile.css(".social-icon-container a").collect {|i| i.attribute("href").value}
    twitter_link = social_links.select {|i| i.include?("twitter")}.first
    linkedin_link = social_links.select {|i| i.include?("linkedin")}.first
    github_link = social_links.select {|i| i.include?("github")}.first
    blog_image = student_profile.css(".social-icon-container a img").collect {|i| i["src"]}.grep(/rss-icon.png/).count

    profile[:twitter] = twitter_link if twitter_link != nil
    profile[:linkedin] = linkedin_link if linkedin_link != nil
    profile[:github] = github_link if github_link != nil

    if blog_image == 1
      profile[:blog] = social_links.last
    end

    profile[:profile_quote] = student_profile.css(".vitals-text-container .profile-quote").text
    profile[:bio] = student_profile.css(".details-container p").text

    profile
  end
end
