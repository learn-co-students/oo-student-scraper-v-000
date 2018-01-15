require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    hashes = []

    doc.css("div.roster-cards-container div.student-card").each do |student|
      # puts "Student Card = #{student}"
      # puts "Student Name = #{student.css("h4.student-name").text}"
      # puts "Student Location = #{student.css("p.student-location").text}"
      # puts "Student Profile Url = #{student.css("a").attribute("href").value}"
      studentHash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      hashes << studentHash

    end

    hashes

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #puts "Open profile url : #{profile_url} || doc = #{doc}"
    # puts "Name : #{doc.css("div.vitals-text-container h1").text}"
    # puts "Location : #{doc.css("div.vitals-text-container h2").text}"

    twitter_url = ""
    linkedin_url = ""
    github_url = ""
    blog_url = ""

    doc.css("div.social-icon-container a").each do |link|
      # puts "Link = #{link}"
      stringLink = link.to_s

      twitter_url = stringLink.split('"')[1] if stringLink.include? "twitter"
      linkedin_url = stringLink.split('"')[1] if stringLink.include? "linkedin"
      github_url = stringLink.split('"')[1] if stringLink.include? "github"

      #Note : Using !(Everything) didn't work - not sure why that was as it only let github through
      if !(stringLink.include?("twitter")) && !(stringLink.include?("linkedin")) && !(stringLink.include?("github"))
        blog_url = stringLink.split('"')[1]
      end
    end

    # puts "Twitter : #{twitter_url}"
    # puts "LinkedIn : #{linkedin_url}"
    # puts "Github : #{github_url}"
    # puts "Blog : #{blog_url}"

    # puts "Biography : #{doc.css("div.description-holder p").text}"
    # puts "Profile Quote : #{doc.css("div.profile-quote").text}"
    # puts "Profile URL : #{profile_url}"

    ##Note : The below did not work because it automatically created keys for each of the data points when it should only be creating them if data existed (and the "main" bits of information apparently were not meant for this part lol)
    # tempHash = {
    #   # :name => doc.css("div.vitals-text-container h1").text,
    #   # :location => doc.css("div.vitals-text-container h2").text,
    #   :twitter => twitter_url,
    #   :linkedin => linkedin_url,
    #   :github => github_url,
    #   :blog => blog_url,
    #   :profile_quote => doc.css("div.profile-quote").text,
    #   :bio => doc.css("div.description-holder p").text
    #   # :profile_url => profile_url
    # }

    tempHash = {}
    tempHash[:twitter] = twitter_url if twitter_url != ""
    tempHash[:linkedin] = linkedin_url if linkedin_url != ""
    tempHash[:github] = github_url if github_url != ""
    tempHash[:blog] = blog_url if blog_url != ""
    tempHash[:profile_quote] = doc.css("div.profile-quote").text
    tempHash[:bio] = doc.css("div.description-holder p").text

    puts "TempHash = #{tempHash}"

    tempHash

  end

end
