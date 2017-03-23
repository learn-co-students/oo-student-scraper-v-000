require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@array_of_hashes = []

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # method #open(index_url) returns the HTML content of the index.html page specified as the argument
    # calling Nokogiri::HTML method on that HTML content will return a giant HTML nested node string
    # variable doc stores that Nokogiri object (a giant nested node HTML string, i.e., node set)
    doc.search(".student-card")
    # I call #search (same as #css) on doc with argument of the css selector (class of "student-card")
    # This grabs all student elements, i.e., returns an array-like collection of Nokogiri::XML 'student' elements, which all have <div class="student-card">
    doc.search(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.search("h4").text
      student_hash[:location] = student.search("p").text
      student_hash[:profile_url] = "./fixtures/student-site/" << student.search("a")[0]["href"]
      @@array_of_hashes << student_hash
    end
    @@array_of_hashes
  end
  # Explanation of #each iteration from method above:
  # Iterate through the array-like collection of Nokogiri::XML 'student' elements, which were targeted by their <div class="student-card">
  # For each student Nokogiri::XML::element (represented by placeholder |student|),
  # create a new hash stored in the variable student_hash
  # add each key/value pair to the hash using the syntax hash[key] = value
  # the keys are the symbols :name, :location and :profile_url, which will be attributes of each student
  # the keys' corresponding values are the data scraped from the web page
  # Example: to grab a student's :profile_url, call #search on the student Nokogiri::XML::element with css selector of "a" to target links
  # Consequently, an array-like collection of Nokogiri::XML::element targeting profile link is returned.
  # However, even if there was only 1 element in the array for the profile link, we must access it at index 0
  # The profile url is the value for the link's href attribute, hence ["href"]
  # student.search("a")[0]["href"] only returns the string "students/some-name.html"
  # So using the shovel operator, I pushed this string onto the end of the "./fixtures/student-site/" string
  # Each student hash that was created and populated with key/value pairs during the iteration
  # is then pushed into the array of all student hashes, stored in the class variable @@array_of_hashes
  # the return value is the last line of the method, the @@array_of_hashes, which stores all student hashes

  def self.scrape_profile_page(profile_url)
    student_profile_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    all_social_links = doc.search(".social-icon-container a")
    url_array = all_social_links.map {|link| link["href"]}
    url_array.each do |url|
      url_parts = url.split(/\.|\//)
      if url_parts.include?("twitter")
        student_profile_hash[:twitter] = url
      elsif url_parts.include?("linkedin")
        student_profile_hash[:linkedin] = url
      elsif url_parts.include?("github")
        student_profile_hash[:github] = url
      else
        student_profile_hash[:blog] = url
      end
    end
    student_profile_hash[:profile_quote] = doc.search(".profile-quote").text
    student_profile_hash[:bio] = doc.search("p").text
    student_profile_hash
  end
end
# Explanation of #scrape_profile_page class method above:
# Create a new hash {} saved to student_profile_hash variable, which will ultimately store individual student's attributes
# The doc variable stores giant nested node HTML string, which is the content of a single student's profile page
# Calling #search (same as #css method) on doc with CSS selectors (see below)
# go inside the <div class="social-icon-container"> and grab all the anchor links (there are 4 <a>)
# #search returns all_social_links (array-like collection of Nokogiri::XML:: 'link 'elements)
# Call #map on all_social_links array-like collection of link Nokogiri::XML elements
# Using #map, iterate through all_social_links 'array' and for each link element,
# do link["href"] to get the value of the href attribute of each link, which is the URL for the social icon link.
#map returns this array of URLS, stored in variable url_array
# Below is a sample url_array:
#["https://twitter.com/jmburges",
# "https://www.linkedin.com/in/jmburges",
# "https://github.com/jmburges",
# "http://joemburgess.com/"]
# Using #each, iterate through each URL string element of the array.
# On each URL string, call #split with Regex to split the string at either a period . or a / slash
# #split returns an array of URL components, saved to variable url_parts
# a sample array for the first URL link above would be ["https:", "", "twitter", "com", "jmburges"]
# because words twitter, linkedin, github and blog site will all be followed by a period
# but preceded by either a / or . We can isolate these words as elements in the url_parts array
# chose to do this because variability if links start with https or http and
# I need to identify the particular URL to particular social icon
# check to see if url_parts array for each url contains the name of the social icon type (twitter, linkedin, github)
# Use syntax hash[key] = value to assign the URL link (value) to its corresponding key social icon attribute
# values for the blog key might vary according to what the blog website is, so use else condition to assign this 4th link
# After the #each iteration is over, grab the profile_quote value with scraping:
# Call #search on doc with css selectors to target the <div class="profile-quote", returning array-like collection
# Then call #text on this array-like collection of nokogiri xml elements to obtain the text for profile quote
# For the bio value, we call #search on doc with CSS selector of paragraph
# to obtain array-like collection of Nokogiri XML paragraph elements, and then call #text afterward to get text
# return the hash at the end of the method
