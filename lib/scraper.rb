require 'open-uri'
require 'pry'

# Responsible for scraping data from the webpage that lists all the students
class Scraper

  # The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url
  def self.scrape_index_page(index_url)
    student_index_array = []

    doc = Nokogiri::HTML(open(index_url))
    # doc.css(".student_card a .card-text-container h4").text

    # The collection of students
    student_index_array = []
    # The css for the section of the page with student info
    page = doc.css(".roster .roster-cards-container")

    url_prefix = "./fixtures/student-site/students/"
    page.collect do |stu|

      stu.css('.student-card').each do |student|
        student_index_array <<  {name: student.css('h4').text, location: student.css('p').text, profile_url: url_prefix + student.css('h4').text.downcase.split.join("-") + ".html"}
          # profile_url: student.css("a").collect {|links| links.attributes['href'].text}.join}
      end
    end
    student_index_array
  end


  def self.scrape_profile_page(profile_url)
    #     # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(open(profile_url))
    student_profile=[]
    social_hash={}
    social_array = []
    doc.css(".main-wrapper profile")
    # This contains the links for the following:
    # twitter (if present), linkedin, github
    social = doc.css(".vitals-container .social-icon-container")
    # twitter = social.css("a").first['href']
    # social.each do |social|
    #   twitter = social.css("a[href]~=github").text
    #   binding.pry
    # end
    # twitter =  social.css("a").first['href']
    # linkedin = social.css("a")[1]['href']
    # github = social.css("a")[2]['href']
    profile_quote = doc.css(".vitals-text-container .profile-quote").text
    bio = doc.css(".details-container p").text
    student_profile << {twitter: nil, linkedin: nil, github: nil, blog: nil, profile_quote: profile_quote, bio: bio}

    # Try iterating and adding each link to social_array
    social.css("a").each do |link|
      social_array << link["href"]
    end # end of enumerable over social links
    social_array.each do |soc_link|
      if soc_link.include?("twitter")
        social_hash[:twitter] = soc_link
      elsif soc_link.include?("github")
        social_hash[:github] = soc_link
      elsif soc_link.include?("linkedin")
        social_hash[:linkedin] = soc_link
      else
        social_hash[:blog] = soc_link
      end
    end
    # merge hashes and delete elements that weren't found
    student_profile[0].merge(social_hash).delete_if {|k,v| v.nil?}
  end

end
