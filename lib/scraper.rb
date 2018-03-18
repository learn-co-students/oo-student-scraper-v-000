require 'open-uri'
require 'pry'

class Scraper
  attr_reader :attribute, :profile_url

def self.scrape_index_page(index_url)
  students = []

  hash_array = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
      students_array = hash_array.css(".student-card").collect do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      student =
        {:name => name,
        :location => location,
        :profile_url => profile_url
        }
      students << student
        # binding.pry
  end
      students
      # binding.pry
  end

  def self.scrape_profile_page(profile_url)
     student = {}
    page = Nokogiri::HTML(open("./fixtures/student-site/students/joe-burgess.html"))
      #  binding.pry
    page.css("div.vitals-container").each do |first|
    # name = first.css("div.vitals-text-container h1.profile-name").text
          #  binding.pry
        twitter = first.css("div.social-icon-container a")[0].attribute("href").value
        linkedin = first.css("div.social-icon-container a")[1].attribute("href").value
        github = first.css("div.social-icon-container a")[2].attribute("href").value
        blog = first.css("div.social-icon-container a")[3].attribute("href").value
        profile_quote = first.css("div.profile-quote").text
        bio = page.css("div.details-container").css("div.description-holder p").text
        # binding.pry
    # student[name.to_sym] = {
    # student[:name] = name
      student[:twitter] = twitter #if value.include?("twit")
      student[:linkedin] = linkedin #if value.include?("linkedin")
      student[:github] = github  #if value.include?("github")
      student[:blog] = blog
      student[:profile_quote] = profile_quote
      student[:bio] = bio

    end
    student
  end
end

# (div.dexcription-holder).
# Scraper.scrape_index_page("./fixtures/student-site/index.html")
# css("div.vitals-container")
