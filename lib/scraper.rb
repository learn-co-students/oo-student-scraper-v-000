require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
      student_site = Nokogiri::HTML(open(index_url))

      students_index = []
      i = 0

      student_site.css("div.student-card").each do |student|
        students_index[i] = {
          :name => student.css("div.card-text-container h4.student-name").text,
          :location => student.css("div.card-text-container p").text,
          :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
        }
        i += 1
      end

        students_index
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    twitter = ''
    linkedin = ''
    github = ''
    blog = ''

    profile.css("div.social-icon-container a").each do |social|

      social_attr = social.css("img.social-icon").attribute("src").value

      if social_attr == "../assets/img/twitter-icon.png"
        twitter = social.attribute("href").value
      elsif social_attr == "../assets/img/linkedin-icon.png"
        linkedin = social.attribute("href").value
      elsif social_attr == ("../assets/img/github-icon.png")
        github = social.attribute("href").value
      else
        blog = social.attribute("href").value
      end

    end


    profile_page = {
        :twitter => twitter,
        :linkedin => linkedin,
        :github => github,
        :blog => blog,
        :profile_quote => profile.css("div.vitals-text-container div.profile-quote").text,
        :bio => profile.css("div.details-container div.description-holder p").text
      }

      profile_page.delete_if { |key, value| value == '' }



  end


end

#way too long way that works..

# social_attr = profile.css("div.social-icon-container img.social-icon").attribute("src").value
# social_arr = []
# i=0

# profile.css("div.social-icon-container a").each do |social|
#   social_arr[i] = profile.css("div.social-icon-container a")[i].attribute("href").value
#   i += 1
# end

# social_arr.each do |soc|
#   if soc.include? "twitter"
#     twitter = soc
#   elsif soc.include? "linkedin"
#     linkedin = soc
#   elsif soc.include? "github"
#     github = soc
#   else
#     blog = soc
#   end
# end
