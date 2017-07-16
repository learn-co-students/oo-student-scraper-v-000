require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # sample result
      # [{:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
      #  {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
      #  {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"}]
    html = open(index_url)
    index = Nokogiri::HTML(html)
    students = []
    index.css("div.student-card").each do |item|
      student = {
        name: item.css("div.card-text-container h4.student-name").text,
        location: item.css("div.card-text-container p.student-location").text,
        profile_url: item.css("a").attribute("href").value
      }
      students << student
    end
    # binding.pry
    students
    # :profile_url => index.css("div.student-card a").attribute("href").value
    # :name => index.css("div.cart-text-container h4.student-name").text
    # :location => index.css("div.cart-text-container p.student-location").text
  end

  def self.scrape_profile_page(profile_url)
    # sample result
      # {:twitter=>"http://twitter.com/flatironschool",
      #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
      #   :github=>"https://github.com/learn-co,
      #   :blog=>"http://flatironschool.com",
      #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      #   :bio=> "I'm a school"
      #  }
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    social = []
    # get all the social elements
    profile.css("div.vitals-container div.social-icon-container a").each do |link|
      social << link.attribute("href").value
    end
    # use the mass assignment method to create and assign key/value pairs to the student hash?
    student = {
      twitter: social.detect {|url| url.match(/(twitter)/)},
      linkedin: social.detect {|url| url.match(/(linkedin)/)},
      github: social.detect {|url| url.match(/(github)/)},
      blog: social.detect {|url| !url.match(/(twitter)|(facebook)|(linkedin)|(github)/)},
      profile_quote: profile.css("div.vitals-text-container div.profile-quote").text,
      bio: profile.css("div.details-container div.bio-content div.description-holder p").text
    }
    # remove any nil values
    student.delete_if {|k, v| v.nil?}

    # #reject is like #delete_if but returns a copy of the hash => like usuing hash.dup.delete_if

    # elements needed: twitter url, linkedin url, github url, blog url, profile quote, and bio

      # how do you make sure that you pick twitter and linkedin? => use the img src?
      # linkedin - ../assets/img/linkedin-icon.png
      # twitter - ../assets/img/twitter-icon.png
      # github - ../assets/img/github-icon.png
      # or could you use regex to make sure that the url has "https://twitter.com", "https://www.linkedin.com", "https://github.com"
      # twitter: social.detect {|url| url.match(/(twitter)/)}
      # linkedin: social.detect {|url| url.match(/(linkedin)/)}
      # github: social.detect {|url| url.match(/(github)/)}
      # blog: social.detect {|url| !url.match(/(twitter)|(facebook)|(linkedin)|(github)/)}
      # profile_quote: profile.css("div.vitals-text-container div.profile-quote").text
      # bio: profile.css("div.details-container div.bio-content div.description-holder p").text
      # social = []
        # profile.css("div.vitals-container div.social-icon-container a").each {|link| social << link.attribute("href").value}
  end

end
