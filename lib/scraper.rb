require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url) #want to accept any site.

    # html = File.read("http://students.learn.co/students/niki-lee.html")
    student_list = Nokogiri::HTML(open(index_url))
    students = []

    student_list.css("div.roster-cards-container").each do |card|  #iterate 1st step
       card.css('.student-card a').each do |student| #iterate 2nd step deeper.
        #when is has a dot  "." means is a class...

        url = "#{student.attr('href')}" #attr get the element of a certian attributes in a inspect   webpage.
        name = student.css('.student-name').text
        location = student.css('.student-location').text

        students << {name: name, location: location, profile_url: url}
      end
    end

    students   #return student an use it in another method.
  end

  def self.scrape_profile_page(profile_url) #This another Scraper method.
      student_profile = Nokogiri::HTML(open(profile_url))
      profile = {}

      links = student_profile.css(".social-icon-container").children.css("a").collect {|icon| icon.attribute("href").value}
      #  .... It independent of the other methods
      bio = student_profile.css('.description-holder > p').text   # when we want to get a nested text , or hi... Drill down as specific as possible... becsu cut down on formatiing issues...  so add space or greaten than smybol. then the syntax...  p, or h
      profile_quote = student_profile.css('.profile-quote').text
      profile[:bio] = bio
      profile[:profile_quote] = profile_quote

        # iterater through link.. using .each  |link|
      links.each do |link|
        "Reduce to a previously solved problem"
        if link.include?("github")
          profile[:github] = link
        elsif link.include?("linkedin")
          profile[:linkedin] = link
        elsif link.include?("twitter")
          profile[:twitter] = link
        else
          profile[:blog] = link  #the other socail media has the name in the link except blog.. so we call it link
        end
      end
    profile
  end
end
