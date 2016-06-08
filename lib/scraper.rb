require 'open-uri'
require 'pry'

class Scraper

@all_students = []

  def self.scrape_index_page(index_url)
    html = index_url.chomp("fixtures/student-site/index.html")
    doc = Nokogiri::HTML(open(html))

    students = {}
    # doc.css("roster-body-wrapper").each do 
    doc.css("div.student-card").each do |student|
      title = doc.css("div.student-card").attribute("id").value
      students = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => html+student.css("a").attribute("href").value
      }

    @all_students << students
    end
    @all_students
    # doc = Nokogiri::HTML(open("http://127.0.0.1:4000/"))
    #doc.css("h4").text == name of student
    #doc.css("p").text == location
    #doc.css('div.student-card a').attribute("href").value
  end

  def self.scrape_profile_page(profile_url)
    html = profile_url.gsub("fixtures/student-site/", "")
    doc = Nokogiri::HTML(open(html))

    links = {}
      doc.css("div.social-icon-container a").each do |media|
        if media.attribute("href").value.include? "twitter"  
          links[:twitter] = media.attribute("href").value
        elsif media.attribute("href").value.include? "linkedin"
          links[:linkedin] = media.attribute("href").value  
        elsif media.attribute("href").value.include? "github"
          links[:github] = media.attribute("href").value 
        else
          links[:blog] = media.attribute("href").value
          links[:profile_quote] = doc.css("div.profile-quote").text
          links[:bio] = doc.css("div.description-holder p").text
          binding.pry
        end
      end
      # binding.pry

      # doc.css("div.description-holder").each do |student|
      #   links[:bio] = student.text
      # end
      # binding.pry
        links
# so at the moment the only things I've seen that can be collected
#are twitter, linkedin.com, github.com, 

#calling twitter



#     doc.css("div.social-icon-container a").attribute("href")
#     => #(Attr:0x3fc272d4dd38 { name = "href", value = "https://twitter.com/jmburges" })
#     doc.css("div.social-icon-container a").each do |media|
#       puts media.attribute("href")
#     end 
  end













end

