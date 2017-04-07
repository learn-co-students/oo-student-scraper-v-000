require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      student_stuff = Nokogiri::HTML(open(index_url))


      students = []

      student_stuff.css("div.roster-cards-container").collect do |cards|
        cards.css(".student-card").each do |student|
           aname = student.css("h4.student-name").text
           aprofile_url = "./fixtures/student-site/#{student.css("a").attribute("href").value}"

           alocation = student.css("p.student-location").text
            students << {name: aname, location: alocation, profile_url: aprofile_url }
          end
      end

      students


  end

  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open(profile_url))

    social = student_page.css("div.vitals-container div.social-icon-container a")
    test = []
    test_hash = {}
    type_str=""
    test_array = []
    social.collect do |social_links|

      social_links.each do |type|
          type_str = type[1].to_str
          puts "#{type_str}"
          puts "#{type_str.include? 'twitter'}"
          test_array << type[1].to_str
           !test_array.include? "twitter"
            if type_str.include? "twitter"
              test_hash[:twitter] = type_str
            elsif type_str.include? "linkedin"
              test_hash[:linkedin] = type_str
            elsif type_str.include? "github"
              test_hash[:github] = type_str
            end

      end
    end
    #  if test_hash[:twitter] == nil
    #    test_hash[:twitter] =  " "
    #  end
    #  if test_hash[:github] == nil
    #    test_hash[:github] =  " "
    #  end
    #  if test_hash[:linkedin] == nil
    #    test_hash[:linkedin] =  " "
    #  end
    binding.pry
    test_hash
    end


    #social = student_page.css("div.vitals-container div.social-icon-container a").attribute("href").value

    #if social.include? "twitter"
    #  twitter = social
    #else
    #  twitter = ""
    #end

    #if social.include? "linkedin"
    #  linkedin = social
    #else
      #linkedin = ""
    #end

    #if social.include? "github"
      #github = social
    #else
      #github = ""
    #end


  #  st_info = {
  #    :twitter => twitter,
  #    :linkedin => linkedin,
  #    :github => github,

  #  }




end
