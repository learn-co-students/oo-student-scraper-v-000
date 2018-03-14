require 'open-uri'
require 'pry'

class Scraper
  @@all = []


  def self.all
    @@all
  end

  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open(index_url))
    #binding.pry
    students = []

    index_url.css("div.student-card").map do |card|
      student = {}
      student[:name] = card.css('.student-name').text
      student[:location] = card.css('.student-location').text
      #binding.pry
      student[:profile_url] = card.css("a[href]").attr("href").value

      # get data just from this card
      # we can create our student hash
      # push to the students array
      students << student


    end
    students.compact
  end
  #binding.pry
  #   student_name = index_url.css(".card-text-container").css(".student-name").map {|stu_name| stu_name.text}
  #   student_location = index_url.css(".card-text-container").css("p.student-location").map {|location| location.text}
  #
  #   student_profile_url = index_url.css(".student-card a").attr("href").value
  #   binding.pry
  #
  #
  #
  # students << {name: student_name, location: "student_location", profile_url: "student_profile_url"}
  # profile_url.search("//a").each do |social|
  #   puts social["href"]

  def self.scrape_profile_page(profile_url)
    profile_url = Nokogiri::HTML(open(profile_url))
    #binding.pry
    student = {}
    students = []

    profile_url.search("//a").detect {|social| puts student[:twitter] = social["href"] if social["href"].include?("twitter")}
    profile_url.search("//a").detect {|social| puts student[:linkedin] = social["href"] if social["href"].include?("linkedin")}
    profile_url.search("//a").detect {|social| puts student[:github] = social["href"] if social["href"].include?("github")}
    profile_url.search("//a").detect {|social| puts student[:blog] = social["href"] if social["href"].include?("http:")}
    # profile_url.css(".social-icon-container").children.css("a").each do |blog|
    # if blog.include?("../assets/img/rss-icon.png")
    #   binding.pry
    #   if blog.include?("github") || blog.include?("linkedin") || blog.include?("twitter") == false
    # student[:blog] = if profile_url.css(".social-icon-container").css("a").children.attr("src").value == "../assets/img/rss-icon.png"
    #   profile_url.css(".social-icon-container").css("a").attribute("href").value
    student[:profile_quote] = profile_url.css(".profile-quote").text
    student[:bio] = profile_url.css(".description-holder p").text

    students << student
    student


  end
end


#   end        binding.pry
#           if link.include? ("twitter.com")
#         student[:twitter] = social
#           if social.include?("linkedin")
#         student[:linkedin] = social
#       else
#         nil
#
#         # student[:github] = social
#         # student[:blog] = social
#         # student[:profile_quote] = social
#         # student[:bio] = social
#
#
#         students << student
#
#     end
#   end
# end
# end
# students.compact
# end
# end


# student[:github] = card.css("a[href]").attr("href").value
# student[:blog] = card.css("a[href]").attr("href").value
# student[:profile_quote] = card.css("a[href]").attr("href").value
# student[:bio] = card.css("a[href]").attr("href").value
#binding.pry
#index_url.css("div.student-card").map {|name| name.text}.compact
#student_profile_url = student_profile_urls.split().each do |student_profile_url|
#students.css(".student-name").first.text
#index_url.css(".student-card .card-text-container .student-location").text
#index_url.css(".student-card a[href]").attr("href").value
# students[:name] << student_name
# students[:location] << student_location

# students[:profile_url] << student_profile_url
