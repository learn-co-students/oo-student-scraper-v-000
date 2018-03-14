require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)
    student_array = []
     index_page.css("div.roster-cards-container").each do |c|
       c.css("div.student-card a").each do |s|
         link = s.attr("href")
         student_name = s.css("div.card-text-container h4").text
         student_location = s.css("div.card-text-container p").text

        student_array << {name: student_name, location: student_location, profile_url: link}
      end
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    student_hash = {}
    # binding.pry
    social_array = profile_page.css(".social-icon-container a").collect {|social| social.attr("href")}
      social_array.each do |link|
        if link.include?("twitter")
          student_hash[:twitter] = link
        elsif link.include?("linkedin")
          student_hash[:linkedin] = link
        elsif link.include?("github")
          student_hash[:github] = link
        else
          student_hash[:blog] = link
        end
      end
      student_hash[:profile_quote] = "#{profile_page.css('div.vitals-text-container div.profile-quote').text}"
      student_hash[:bio] = "#{profile_page.css("div.description-holder p").text}"
      student_hash
    end

end

# if icon.css("img.social-icon").attr("src").value == "../assets/img/twitter-icon.png"
#   twit = icon.attr("href")
# elsif icon.css("img.social-icon").attr("src").value == "../assets/img/linkedin-icon.png"
#   linked = icon.attr("href")
# elsif icon.css("img.social-icon").attr("src").value == "../assets/img/github-icon.png"
#   git = icon.attr("href")
# elsif icon.css("img.social-icon").attr("src").value == "../assets/img/rss-icon.png"
#   blogblog = icon.attr("href")
# end
