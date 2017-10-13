require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))# "./fixtures/student-site/index.html"
    students = []
    doc.css("div.roster-cards-container").each do |c|
      c.css(".student-card a").each do |student|
        student = {
         :profile_url => student.attr('href'),
         #student[:profile_url] = student.attr('href') outside of the {}
         :name => student.css(".student-name").text,
         :location => student.css(".student-location").text
       }
       students<<student
       end
     end
    students
     # students = {}
     # student[:profile_url] = student.attr('href')
     #student[:name] = student.css.....
    #student[:location] = student.css....


  end

  def self.scrape_profile_page(profile_url)#  #students/fname-lname.html      ./fixtures/student-site/students
    doc = Nokogiri::HTML(open(profile.url))
    binding.pry
    each_student = []
    doc.css(". ").each do |student|
    #   student.css(".social-icon-container ").each do|s|
        a.attr('href')
    "twitter".included?("twitter")
    these 3 are(".social-icon-container").children.map do |social|
         student_twitter =href .src("")
        student_linkedin =  a href  .src("")
        student_github =  a href   .src("")

        student_blog =

       (".details-container description-holder")
        student_bio =

       (".vitals-text-container profile-quote")
        student_profile_quote = s.css(".profile-quote").text

      end
    end
    profiles

end
