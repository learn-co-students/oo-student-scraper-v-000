require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.student-card").each do |student|
      #pry(Scraper)> index_page.css("div.student-card").first shows the invidual elements of each person

      student_hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").first["href"] # <- [] because its a key
      #student.css("a").class "a" is for links
      #student.css("a").first shows all the elements of a
      }
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    links = profile_page.css("div.social-icon-container a").collect do |link|
      link.attribute("href").value
    end

    scraped_student = {
      :bio => profile_page.css("div.description-holder p").first.children.text,
      #used .first in pry and put the pieces together.
      :profile_quote => profile_page.css("div.profile-quote").text


      #examples:
      # :linkedin=>"https://www.linkedin.com/in/flatironschool",
      # :github=>"https://github.com/learn-co,
      # :blog=>"http://flatironschool.com",
      # :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      # :bio=> "I'm a school"
      # :twitter =>
    }

    links.each do |link|
      if link.include?('twitter') #checks whole array without split
        scraped_student[:twitter] = link
      elsif link.include?('linkedin')
         scraped_student[:linkedin] = link #I hate stackoverflow -Mohammed Chisti
      elsif link.include?('github')
          scraped_student[:github] = link
      else
        scraped_student[:blog] = link
      end
    end
    scraped_student
    #required a return of scraped_student. Was returning link
    #attributes work differently in css ^ not here     qq        but here ^
    #Nodes behave similar to a hash buts more like an array.
  end

end
