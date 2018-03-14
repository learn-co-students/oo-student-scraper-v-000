require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :twitter, :blog, :facebook, :github, :linkedin

  def self.scrape_index_page(index_url)
    index_info = Nokogiri::HTML(open(index_url))

    students = []
    index_info.css("div.student-card").each_with_index do |people, idx|

      students[idx]= {
        :name => people.css("div.card-text-container h4.student-name").text,
        :location => people.css("div.card-text-container p.student-location").text,
        :profile_url => people.css("a")[0]['href']}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    split_array = profile.css("div.social-icon-container").text.split('')
    total_links = split_array.count{|a|a =="\n"} -1


     if profile.css("a")[1]['href'].include?("twitter")
        link1 = "twitter"
      elsif profile.css("a")[1]['href'].include?("linkedin")
        link1 = "linkedin"
      elsif profile.css("a")[1]['href'].include?("github")
        link1 = "github"
      elsif profile.css("a")[1]['href'].include?("facebook")
        link1 = "facebook"
      else
        link1 = "blog"
      end


    if profile.css("a")[2]['href'].include?("twitter")
       link2 =  "twitter"
      elsif profile.css("a")[2]['href'].include?("linkedin")
        link2 = "linkedin"
      elsif profile.css("a")[2]['href'].include?("github")
       link2 =  "github"
      elsif profile.css("a")[2]['href'].include?("facebook")
        link2 = "facebook"
      else
       link2 =  "blog"
      end

      if total_links < 3
        nil
      else
        if profile.css("a")[3]['href'].include?("twitter")
           link3 = "twitter"
        elsif profile.css("a")[3]['href'].include?("linkedin")
           link3 = "linkedin"
        elsif profile.css("a")[3]['href'].include?("github")
           link3 = "github"
        elsif profile.css("a")[3]['href'].include?("facebook")
           link3 = "facebook"
        else
           link3 = "blog"
        end
      end

      if total_links < 4
        nil
      else
        if profile.css("a")[4]['href'].include?("twitter")
         link4 =  "twitter"
        elsif profile.css("a")[4]['href'].include?("linkedin")
         link4 =  "linkedin"
        elsif profile.css("a")[4]['href'].include?("github")
         link4 =  "github"
        elsif profile.css("a")[4]['href'].include?("facebook")
         link4 =  "facebook"
        else
         link4 =  "blog"
        end
      end

      if total_links < 5
        nil
      else
        if profile.css("a")[5]['href'].include?("twitter")
          link5 = "twitter"
        elsif profile.css("a")[5]['href'].include?("linkedin")
          link5 = "linkedin"
        elsif profile.css("a")[5]['href'].include?("github")
          link5 = "github"
        elsif profile.css("a")[5]['href'].include?("facebook")
         link5 =  "facebook"
        else
          link5 = "blog"
        end
      end



    case total_links
    when 1
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text,
        link1.to_sym => profile.css("a")[1]['href'],
      }
    when 2
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text,
        link1.to_sym => profile.css("a")[1]['href'], link2.to_sym => profile.css("a")[2]['href']
      }
    when 3
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text,
        link1.to_sym => profile.css("a")[1]['href'], link2.to_sym => profile.css("a")[2]['href'], link3.to_sym => profile.css("a")[3]['href']
      }
    when 4
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text,
        link1.to_sym => profile.css("a")[1]['href'], link2.to_sym => profile.css("a")[2]['href'], link3.to_sym => profile.css("a")[3]['href'], link4.to_sym => profile.css("a")[4]['href']
      }
    when 5
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text,
        link1.to_sym => profile.css("a")[1]['href'], link2.to_sym => profile.css("a")[2]['href'], link3.to_sym => profile.css("a")[3]['href'], link4.to_sym => profile.css("a")[4]['href'], link5.to_sym => profile.css("a")[5]['href']
      }
    else
      student = {
        :profile_quote => profile.css("div.profile-quote").text,
        :bio => profile.css("div.description-holder p").text}
    end

  end

end

