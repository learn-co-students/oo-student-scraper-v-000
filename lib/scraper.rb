require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_arr = []

    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".student-card")
      students.each do |stu|
        student_arr << {:name => stu.css(".student-name").text, :location => stu.css(".student-location").text, :profile_url => "./fixtures/student-site/#{stu.css("a")[0]['href']}"}
      end
      student_arr

  end

  def self.scrape_profile_page(profile_url)
        twit = nil
        linkd = nil
        git = nil
        blog = nil
        quote = nil
        bio = nil

        doc = Nokogiri::HTML(open(profile_url))
        social = doc.css("a")
        # binding.pry
          social.each do |link|
            # binding.pry
            if link['href'].include?("twitter")
              twit = link['href']
              # binding.pry
            elsif link['href'].include?("linkedin")
              linkd = link['href']
            elsif link['href'].include?("github")
              git = link['href']
            else
              blog = link['href']
            end
          end

          quote = doc.css(".profile-quote").text.delete("\"")
          bio = doc.css(".bio-block .description-holder p").text
binding.pry
  end

end
