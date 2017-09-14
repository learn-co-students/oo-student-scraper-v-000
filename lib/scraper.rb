require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    result = []
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    student_array = doc.css("div.student-card")

    student_array.each do |student_card|
      name = student_card.css("h4.student-name").text
      location = student_card.css("p.student-location").text
      profile_url = student_card.css("a")[0]["href"]

      student = {:name => name, :location => location, :profile_url => profile_url}
      result << student
    end #end each
    result
  end

  def self.scrape_profile_page(profile_url)


    doc = Nokogiri::HTML(open("#{profile_url}"))

    binding.pry
    social_media = doc.css("div.social-icon-container a")[0]["href"]
    # blog_url = ????
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text



    # scraped_student = {
    #   :twitter_url => twitter_url,
    #   :linkedin_url => linkedin_url,
    #   :github_url => github_url,
    #   :blog_url => blog_url,
    #   :profile_quote => profile_quote,
    #   :bio => bio
    # }
    #
    # scraped_student

    #Some students don't have a twitter or some other social link. Be sure to be able to handle that.

  end

end
