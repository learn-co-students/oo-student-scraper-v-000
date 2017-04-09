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
    info_hash = {}
    type_str=""
    social_array = []

    descrip = student_page.css("div.details-container div.description-holder p").text

    prof_quote = student_page.css("div.profile-quote").text

    social.collect do |social_links|
      social_links.each do |type|
          type_str = type[1].to_str
          #puts "#{type_str}"
          #puts "#{type_str.include? 'twitter'}"
          #test_array << type[1].to_str
           !social_array.include? "twitter"
            if type_str.include? "twitter"
              info_hash[:twitter] = type_str
            elsif type_str.include? "linkedin"
              info_hash[:linkedin] = type_str
            elsif type_str.include? "github"
              info_hash[:github] = type_str
            else
              info_hash[:blog] = type_str
            end

      end
    end

    info_hash[:bio] = descrip
    info_hash[:profile_quote] = prof_quote


    info_hash
    end





end
