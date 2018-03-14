require 'nokogiri'
require 'open-uri'
require 'pry'

# for index.html
# to grab first student: first = html.css("div.student-card").first
# to grab first student's name: first.css("h4.student-name").text
# to grab first student's location: first.css("p.student-location").text
# to grab first student's profile_url: first.css("a").attribute("href").value

# for student profile
# to grab twitter_url: student_html.css("a[href*='twitter.com']").attribute("href").value
# to grab linkedin_url: student_html.css("a[href*='linkedin.com']").attribute("href").value
# to grab github_url: student_html.css("a[href*='github.com']").attribute("href").value
# to grab blog_url: student_html.css("div.social-icon-container a:last-child").attribute("href").value
# to grab profile_quote: student_html.css("div.profile-quote").text
# to grab bio: student_html.css("div.bio-content div.description-holder p").text

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students_html = html.css("div.student-card")
    students_hash = []
    students_html.each do |student_html|
      name = student_html.css("h4.student-name").text
      location = student_html.css("p.student-location").text
      profile_url = index_url.chomp('index.html') + student_html.css("a").attribute("href").value
      students_hash << {name: name, location: location, profile_url: profile_url}
    end
    students_hash
  end

  def self.scrape_profile_page(profile_url)
    student_html = Nokogiri::HTML(open(profile_url))
    twitter_url, linkedin_url, github_url, blog_url, profile_quote, bio = nil, nil, nil, nil, nil, nil
    student_hash = {}
    twitter_url = student_html.css("a[href*='twitter.com']").attribute("href").value if student_html.css("a[href*='twitter.com']").length != 0
    linkedin_url = student_html.css("a[href*='linkedin.com']").attribute("href").value if student_html.css("a[href*='linkedin.com']").length != 0
    github_url = student_html.css("a[href*='github.com']").attribute("href").value if student_html.css("a[href*='github.com']").length != 0
    blog_url = student_html.css("div.social-icon-container a:last-child").attribute("href").value if student_html.css("div.social-icon-container a:last-child").length != 0
    student_hash[:twitter] = twitter_url if twitter_url != nil
    student_hash[:linkedin] = linkedin_url if linkedin_url != nil
    student_hash[:github] = github_url if github_url != nil
    student_hash[:blog] = blog_url if blog_url != nil && blog_url != twitter_url && blog_url != linkedin_url && blog_url != github_url
    profile_quote = student_html.css("div.profile-quote").text if student_html.css("div.profile-quote").length != 0
    bio = student_html.css("div.bio-content div.description-holder p").text if student_html.css("div.bio-content div.description-holder p").length != 0
    student_hash[:profile_quote] = profile_quote if profile_quote != nil
    student_hash[:bio] = bio if bio != nil

    # student_hash = {twitter: , linkedin: , github: , blog: , profile_quote: , bio:  }

    student_hash
  end


end
