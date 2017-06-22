require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)

    index = Nokogiri::HTML(html)

    students = []

    index.css("div.student-card").collect do |student|
      new_student = {}
        new_student[:name] = student.css("h4.student-name").text
        new_student[:location] = student.css("p.student-location").text
        new_student[:profile_url] = student.css("a").attribute("href").value
        # binding.pry
        students << new_student
    end
    students
  end
    #
    # kickstarter.css("li.project.grid_4").each do |project|
    #   title = project.css("h2.bbcard_name strong a").text
    #   projects[title.to_sym] = {
    #     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    #     :description => project.css("p.bbcard_blurb").text,
    #     :location => project.css("ul.project-meta span").text,
    #     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    #   }

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)

    profile = Nokogiri::HTML(html)

    student_profile = {}
    social_arr = profile.css("div.social-icon-container a").collect {|social| social.attribute("href").value }
    social_arr.each do |social|
      if social.include?("twitter")
        student_profile[:twitter] = social
      elsif social.include?("linkedin")
        student_profile[:linkedin] = social
      elsif social.include?("github")
        student_profile[:github] = social
      else social.include?("blog")
        student_profile[:blog] = social
      end
      student_profile[:profile_quote] = profile.css("div.vitals-container div.vitals-text-container div.profile-quote").text
      student_profile[:bio] = profile.css("div.details-container div.bio-block div.description-holder p").text
    end
    student_profile
  end

end
