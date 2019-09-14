require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#when we scrape we have two loops going. The first loop moves the operations to different students (in the roster-cards-container)
#the second loop is iterating within each student to grab the name, location and profile_url
def self.scrape_index_page(index_url)

    html=File.read(index_url)
    index = Nokogiri::HTML(html)
    scraped_students = []

    index.css("div.roster-cards-container").each do |students|
      students.css("div.student-card").each do |student|
        scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attr('href').value
      }
      end
    end
  scraped_students
end


  def self.scrape_profile_page(profile_url)
    #html=File.read("#{profile_url}")
      #binding.pry
    html=File.read(profile_url)
    profile = Nokogiri::HTML(html)
    profile_page = {}

      profile.css("div.main-wrapper.profile").each do |attribute|

          #attribute.collect {|x| x.value == "social-icon-container"}
          attribute.css("div.social-icon-container a").each do |media|
            #binding.pry
            if media.attribute('href').value.include?("twitter")
              profile_page[:twitter] = media.attribute("href").value
            elsif media.attribute('href').value.include?("linkedin")
              profile_page[:linkedin] = media.attribute("href").value
            elsif media.attribute('href').value.include?("github")
              profile_page[:github] = media.attribute("href").value
            else
              profile_page[:blog] = media.attribute("href").value
            end
          end
        profile_page[:profile_quote] = attribute.css("div.profile-quote").text
        profile_page[:bio] = attribute.css("div.description-holder p").text

      end #end outer each
    profile_page
    #binding.pry
  end # end method

end #end class





# First attempt below
# This wouldn't work becuase it is based off the assumption that 4 links exist in the first place.
# If we try to assign a nil value(a link that doesn't exist) to a key, the code breaks. We need to check FIRST THAT it exists, or
# create a loop with conditions such that it goes thru all links regardless of how many, and assigns the links to variables if the conditions are met.
# {
# :twitter=> attribute.css("div.social-icon-container a")[0].attr("href"),
# :linkedin=> attribute.css("div.social-icon-container a")[1].attr("href"),
# :github=>attribute.css("div.social-icon-container a")[2].attr("href"),
# :blog=>attribute.css("div.social-icon-container a")[3].attr("href"),
# :profile_quote=> attribute.css("div.profile-quote").text,
# :bio=> attribute.css("div.description-holder p").text
# }
