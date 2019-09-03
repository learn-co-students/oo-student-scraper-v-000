require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  #div.roster-cards-container
  #div.student-card
  #:name  h4.student-name.text
  #:location p.student-location.text
  #:profile_url a.attribute href.value

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))                                 #open the index_url & set it = to variable
    students = []                                                         #set students = to an array
    doc.css("div.roster-cards-container").each do |student_card|          #iterate through the full container to get the individual student card
      student = {}                                                        #set student = to a hash
      student_card.css("div.student-card").each do |student_attr|         #iterate through the student card to get attributes
        student = {                                                       #set up student hash
          :name => student_attr.css("h4.student-name").text,              #set the symbol :name to the text of h4.student-name (remember the commas at end of lines!)
          :location => student_attr.css("p.student-location").text,       #set the symbol :location to  the text of p.student-location
          :profile_url => student_attr.css("a").attribute("href").value   #set the symbol :profile_url to the value of the href in a
        }                                                                 #close hash
        students << student                                               #push the student hash into the students array
      end                                                                 #end student_card iteration
    end                                                                   #end doc iteration
    students                                                              #return students array
  end                                                                     #end method


  #:twitter => icon.css("a").attribute("href").twitter
  #:linkedin => icon.css("a").attribute("href").linkedin
  #:github => icon.css("a").attribute("href").github
  #:blog =>
  #:profile_quote => doc.css(".profile-quote").text
  #:bio => doc.css("div.description-holder").css("p").text


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))               #open the profile_url and set it = to a variable
    student = {}                                              #set student = to a hash
    profile.css(".social-icon-container a").each do |icon|    #iterate through the full icon container to get to the individual icons
      icon_link = icon.attribute("href").text                 #set the icon href attribute = to a variable
      if icon_link.include?("twitter")                        #ck to see if the word twitter is included in the icon_link variable for this iteration
        student[:twitter] = icon_link                         #if so, set the value for the student hash key for twitter to the icon_link
      elsif icon_link.include?("linkedin")                    #ck to see if the word linkedin is included in the icon_link variable for this iteration
        student[:linkedin] = icon_link                        #if so, set the value for the student hash key for linkedin to the icon_link
      elsif icon_link.include?("github")                      #ck to see if the word github is included in the icon_link variable for this iteration
        student[:github] = icon_link                          #if so, set the value for the student hash key for github to the icon_link
      else                                                    #if none of the above are true
        student[:blog] = icon_link                            #set the value for the student hash key for blog to the icon_link
      end                                                     #end if statement
    end                                                       #end profile iteration

    student[:profile_quote] = profile.css(".profile-quote").text   #set the value for the student hash key for profile quote to profile-quote.text
    student[:bio] = profile.css("p").text                          #set the value for the student hash key for bio to the p text
    student                                                        #return the student hash
  end                                                              #end the method
end                                                                #end the class
