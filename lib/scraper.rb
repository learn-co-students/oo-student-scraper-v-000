require 'open-uri'
require 'nokogiri'  # needed?
require 'pry'

class Scraper

  # Returns an array of hashes with keys :name, :location, and :profile_url
  def self.scrape_index_page(index_url)
    # index_page = Nokogiri::HTML(open("http://127.0.0.1:4000/"))
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    student_list = index_page.css(".student-card")
    student_list.each do |student|
      students << {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => "#{index_url}#{student.css("a").attribute("href").value}"}
    end

    students
  end

  # Take the url of a student profile page and scrape it for links, quote, and bio.
  # Return a hash, student_attributes, that has keys & values for each social link
  # found, as well as for :profile_quote and :bio.
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_attributes = {}

    # Get all the social links.  The keys are extracted from the image file names.
    # The rss key is changed to :blog to pass spec.
    profile_page.css(".social-icon-container a").each do |social_link|

      key = get_key_by_url(social_link)
      if key == nil
        key = get_key_by_icon_name(social_link)
      end

      # check for website/blog by looking for the label "rss" in the icon name.
      blog_check = get_key_by_icon_name(social_link)
      key = "blog" if blog_check == "rss"
      # Add the url link to student_attributes hash with appropriate key
      student_attributes[key.to_sym] = social_link.attribute("href").value
    end

    # Get the profile quote
    student_attributes[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text

    # Get the bio
    student_attributes[:bio] = profile_page.css("div.bio-content p").text

    # binding.pry
    student_attributes
  end

  def self.get_key_by_url(social_link)
    # Use the url link to extract names for keys, taking the part after
    # the "//" in the url and before the ".com"
    key = social_link.attribute("href").value[/(?<=\/\/).*(?=.com)/]

    if key != nil
      # check if the key looks like: www.site
      if key.include?(".")
        key = key.split(".")[1] # Split the key at the . and take the second part
      end
    end
    key
  end

  def self.get_key_by_icon_name(social_link)
    # Return a key string based on the image name.
    key = social_link.css("img.social-icon").attribute("src").value[/(?<=img\/).*(?=-icon)/]
    end
end
