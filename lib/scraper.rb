
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    names = []
    doc.search('h4.student-name').each do |name|
      names << name.text
    end
    locations = []
    doc.search('p.student-location').each do |location|
      locations << location.text
    end
    profile_links = []
    doc.search('a').each do |link|
      profile_links << link['href']
    end
    profile_links = profile_links.drop(1)

    students = []
    names.each { |name| students << {:name => name}}
    l = 0
    locations.each {|location| students[l][:location] = location; l += 1}
    u = 0
    profile_links.each {|profile_url| students[u][:profile_url] = profile_url; u += 1}
    students
  end


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social = []
    profile.search('a').each do |link|
      social << link['href']
    end
    social = social.drop(1)
    student_info = {}
    twitter = nil
    linkedin = nil
    github = nil
    blog = nil
    social.each do |social_link|
      if social_link.include?("twitter") == true
        twitter = social_link
      elsif social_link.include?("linkedin") == true
        linkedin = social_link
      elsif social_link.include?("github") == true
        github = social_link
      else
        blog = social_link
      end
    end
    student_info[:twitter] = twitter unless twitter == nil
    student_info[:linkedin] = linkedin unless linkedin == nil
    student_info[:github] = github unless github == nil
    student_info[:blog] = blog unless blog == nil
    student_info[:profile_quote] = profile.css(".profile-quote").text
    student_info[:bio] = profile.css("p").text
    student_info
  end

end
