require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :students

  @students=[]

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#method is responsible for scraping the index page that lists all of the students
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  def self.scrape_index_page(index_url)
    html=File.read('fixtures/student-site/index.html')
    students=Nokogiri::HTML(html)
    students.css(".student-card").each do |student_css|
      #student=student_css().text
      @students<<{
        :name => student_css.css(".student-name").text,
        :location =>student_css.css(".student-location").text,
        :profile_url => student_css.link.attribute.value
      }
    end

    #@students[0]={location:"", name:"",profile_url:""}
    @students
  end


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#method is responsible for scraping an individual student's profile page to get further information about that student.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  def self.scrape_profile_page(profile_url)

  end

end
