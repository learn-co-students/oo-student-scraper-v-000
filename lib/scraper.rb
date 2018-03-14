require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  @@students = []

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each do |student|
      @@students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").map { |link| link ['href']}.join
      }
    #responsible for scraping the index page that lists all of the students and the
    end
    @@students
  end

  def self.students
    @@students
  end

  def self.scrape_profile_page(profile_url)
      html = File.read(profile_url)
      doc = Nokogiri::HTML(html)
      social_media = {}
    #   THIS METHOD IS HARDCODED FOR ALL SOCIAL LINKS AND IT WORKS
    #   social_media = {
    #    :twitter => doc.css("div.social-icon-container a").map { |link| link ['href']}.first,
    #    :linkedin => doc.css("div.social-icon-container a").map { |link| link ['href']}[1],
    #   :blog => doc.css("div.social-icon-container a").map { |link| link ['href']}.last,
    #     :github => doc.css("div.social-icon-container a").map { |link| link ['href']}[2],
    #     :profile_quote => doc.css("div.profile-quote").text,
    #     :bio => doc.css("div.description-holder p").text
    # }
    #END OF METHOD THAT WORKS

    social_links = doc.css("div.social-icon-container a").map { |link| link ['href']}

    social_media[:profile_quote] = doc.css("div.profile-quote").text
    social_media[:bio] = doc.css("div.description-holder p").text

    social_links.each do |link|
      if link.include?("twitter.com")
        social_media[:twitter] = link
      elsif link.include?("linkedin.com")
        social_media[:linkedin] = link
      elsif  link.include?("github.com")
        social_media[:github] = link
      else
        social_media[:blog] = link
      end
    end
    social_media
  end
end

# BEGIN CASE/SWITCH WIP

    # case social_links
    # when social_links.each {|link|.include? "twitter.com"}
    #   twitter: link
    # when social_links.each {|link|.include? "linkedin.com"}
    #   :linkedin => link
    # when social_links.each {|link|.include? "github.com"}
    #   :github => link
    # else
    #   :blog => link
    # end

    #  CORRECT case/switch METHOD:
    # social_links.each {|link|}
    # case link
    #     when link.include? "twitter.com"
    #       twitter: link
    #     when link.include? "linkedin.com"
    #       :linkedin => link
    #     when link.include? "github.com"
    #       :github => link
    #     else
    #       :blog => link
    #     end
    #end

    # case social_links
    # when "twitter.com"
    #   twitter: link
    # when  "linkedin.com"
    #   :linkedin => link
    # when  "github.com"
    #   :github => link
    # else
    #   :blog => link
    # end

#END OF CASE/SWITCH WIP


# binding.pry
# self.scrape_index_page(index_url)
# self.scrape_profile_page(profile_url)
