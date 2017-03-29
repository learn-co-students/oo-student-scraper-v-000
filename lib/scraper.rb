require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = File.read(index_url)
    data = Nokogiri::HTML(html)

    #binding.pry
    data.css(".student-card").collect do |student|
       #binding.pry
      each_student = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }

      scraped_students << each_student
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    student_social = []
    #binding.pry
     #doc.css("div.profile div.profile-banner").collect do |data|

       doc.css("div.social-icon-container").collect do |social_network|
        student_social = social_network.children.css("a").collect { |s| s.attribute("href").value }
      end
    #end

    student_social.each do |link|
       if link.include? "twitter"
         student[:twitter] = link
       elsif link.include? "linkedin"
         student[:linkedin] = link
       elsif link.include?"facebook"
         student[:facebook] = link
       elsif link.include?"github"
         student[:github] = link
       else
         student[:blog] = link
       end
     end
      student[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text

      bio = doc.css(".details-container .description-holder p").text

      student[:bio] = bio.strip
    #end
    student
  end


end
