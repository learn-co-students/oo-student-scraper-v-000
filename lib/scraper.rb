require 'open-uri'
require 'pry'
require 'nokogiri'

# Responsible for scraping data from the webpage that lists all the students
class Scraper

  # The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url
  def self.scrape_index_page(index_url)
    student_index_array = []

    doc = Nokogiri::HTML(open(index_url))
    # doc.css(".student_card a .card-text-container h4").text

    # {|f| f.each_line {|line| p line}
    # The collection of students
    student_index_array = []
    # The css for the section of the page with student info
    page = doc.css(".roster .roster-cards-container")
    # Arrays for each piece of information
    # names = []
    # locations = []
    urls = []
    # collect student info into an array for each has key

    page.collect do |stu|

      stu.css('.student-card').each do |student|
        student_index_array <<  {name: student.css('h4').text, location: student.css('p').text, profile_url: nil}
          # profile_url: student.css("a").collect {|links| links.attributes['href'].text}.join}
      end

      # collect student names
      # names = stu.css("h4").collect do |name|
      #   name.text
      # end
      #
      # # collect student locations
      # locations = stu.css("p").collect do |location|
      #   location.text
      # end

      # collect student urls
      urls = stu.css("a").collect do |links|
        links.attributes['href'].text
      end

      # student_index_array << {name: student_name, location: student_location, profile_url: student_url}
      # Creat hash and add student names to to new hash in student array
      # names.each do |n|
      #   student_index_array << {name: n}
      # end
      # student_index_array.collect do |hash|
      #   locations.each do |loc|
      #     hash[:location] = loc
        # end
      student_index_array.each do |hash|
        urls.each do |url|
            hash[:profile_url] = "./fixtures/student-site/#{url}"
          end
        end

      student_index_array
      binding.pry
    end
  end


  def self.scrape_profile_page(profile_url)
    # def self.scrape_profile_page(profile_url)
    #     # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    #     doc = Nokogiri::HTML(open(profile_url))
    #     student_profile=[]
    #     social_hash={}
    #
    #     doc.css(".main-wrapper profile").each do |social|
    #
    #       social.css(".social-icon-container").detect do |url|
    #         if url.include?( "twitter")
    #           social_hash[:twitter] = "#{url['href']}"
    #
    #         elsif url.include?("linkedin")
    #           social_hash[:linkedin] = "#{url['href']}"
    #
    #         elsif url.include?("github")
    #           social_hash[:github] = "#{url['href']}"
    #
    #         else social_hash[:blog] = "#{url['href']}"
    #
    #         end
    #       end # end of second enumurable
    #
    #       social_hash[:bio] = social.css("p")
    #       social_hash[:profile_quote] = social.css(".profile-quote")
    #       binding.pry
    #
    #     end # end of first enumerable
    #     social_hash
      # end
  end

end
