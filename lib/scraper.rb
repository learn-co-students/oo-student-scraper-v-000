require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@students_array = []

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))

    #iterate through the students for keys :name, :location, :profile_url
    student_site.css("div.student-card").each do |student|
      profile_url = student.css("a").attribute("href").value
      @@students_array << {
        :profile_url => "./fixtures/student-site/#{profile_url}",
        :name => student.css("a").css("div.card-text-container").css("h4.student-name").text,
        :location => student.css("div.card-text-container").css("p.student-location").text
      }
    end
    @@students_array
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_items = profile_page.css("div.social-icon-container").css("a")
    @student_hash = Hash.new

    profile_items.each do |profile_item|
      if profile_item.css("img").attribute("src").text == "../assets/img/twitter-icon.png"
        twitter_link = profile_item.attribute("href").value
        @student_hash[:twitter] = twitter_link

      elsif profile_item.css("img").attribute("src").text == "../assets/img/linkedin-icon.png"
        linkedin_link = profile_item.attribute("href").value
        @student_hash[:linkedin] = linkedin_link

      elsif profile_item.css("img").attribute("src").text == "../assets/img/github-icon.png"
        github_link = profile_item.attribute("href").value
        @student_hash[:github] = github_link

      elsif profile_item.css("img").attribute("src").text == "../assets/img/rss-icon.png"
        blog_link = profile_item.attribute("href").text
        @student_hash[:blog] = blog_link
      end
    end

    @student_hash[:profile_quote] = profile_page.css("div.profile-quote").text
    @student_hash[:bio] = profile_page.css("div.description-holder").css("p").text

    @student_hash
  end

end
