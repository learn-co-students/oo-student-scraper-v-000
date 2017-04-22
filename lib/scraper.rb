require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      profile_path = student.css("a").attribute("href").value
      student_details[:profile_url] = './fixtures/student-site/' + profile_path
      students << student_details
    end
    students
  end

 def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    binding.pry

    twitter = profile.css("div.main-wrapper.profile .social-icon-container a").first.attribute("href").value
    linkedin = profile.css("div.main-wrapper.profile .social-icon-container a:nth-child(2)").attribute("href").value
    github = profile.css("div.main-wrapper.profile .social-icon-container a:nth-child(3)").attribute("href").value
    blog = profile.css("div.main-wrapper.profile .social-icon-container a").last.attribute("href").value
    profile_quote = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    bio = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile[:twitter] = twitter  if twitter
    student_profile[:linkedin] = linkedin if linkedin
    student_profile[:github] = github if github
    student_profile[:blog] = blog  if blog
    student_profile[:profile_quote] = profile_quote if profile_quote
    student_profile[:bio] = bio if bio

    student_profile
  end  
end
