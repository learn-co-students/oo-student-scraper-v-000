require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_name_array = doc.css(".student-name").map {|name| name.text}
    student_location_array = doc.css(".student-location").map {|name| name.text}
    profile_url_array = doc.css('div.student-card a').map {|link| link['href']}
    output = []
    i = 0
    while i < student_name_array.length
      output << {:name => student_name_array[i], :location => student_location_array[i], :profile_url => "./fixtures/student-site/"+profile_url_array[i]}
      i += 1
    end
    output
  end

  def self.scrape_profile_page(profile_url)

    #scrape-------------------------------------------

    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css('div.social-icon-container a').map {|link| link['href']}

    #isolate links/content----------------------------

    twitter_link = social_links.detect {|link| link.include?('twitter.com')}

    linkedin_link = social_links.detect {|link| link.include?('linkedin.com')}

    github_link = social_links.detect {|link| link.include?('github.com')}

    blog_link = social_links.detect{|link|
       !link.include?('twitter.com') &&
       !link.include?('linkedin.com') && !link.include?('github.com')}

    profile_quote = doc.css("div.profile-quote").text

    bio = bio_content = doc.css("div.description-holder p").text

    #create hash------------------------------------

    output = {}

    if twitter_link
      output[:twitter] = twitter_link
    end

    if linkedin_link
      output[:linkedin] = linkedin_link
    end

    if github_link
      output[:github] = github_link
    end

    if blog_link
      output[:blog] = blog_link
    end

    if profile_quote
      output[:profile_quote] = profile_quote
    end

    if bio_content
      output[:bio] = bio_content
    end

    output
  end

end
