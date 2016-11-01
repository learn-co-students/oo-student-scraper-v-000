require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  html = File.read('fixtures/student-site/index.html')
  index = Nokogiri::HTML(html)
  students=[]
  i=index.css("div.student-card").each do |student|
    profile="./fixtures/student-site/" + student.css("a").attribute("href").value
    name = student.css("div.card-text-container h4.student-name").text
    location = student.css("div.card-text-container p.student-location").text
    students << {:name =>name , :location =>location, :profile_url=>profile}
    #students << student
      end
   students
  end
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.b  bcard_name strong a").text
  def self.scrape_profile_page(profile_url)
 html=File.read(profile_url)
 index = Nokogiri::HTML(html)

i = index.css("div.social-icon-container a")
h={}

if i[0] !=nil
twitter= i[0].attribute("href").value
h[:twitter]=twitter
end
if i[1] !=nil
linked= i[1].attribute("href").value
h[:linkedin]=linked
end
if i[2] !=nil
github= i[2].attribute("href").value
h[:github]=github
end
if i[3] !=nil
blog= i[3].attribute("href").value
h[:blog] =blog
end
quote= index.css("div.profile-quote").text
bio= index.css("div.description-holder p").text

h[:profile_quote] = quote,
h[:bio]= bio
 ##binding.pry
h
end
end
