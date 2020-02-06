require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    #student-card: doc.css('.student-card')
    #name: doc.css('h4').text
    #location: doc.css('p').text
    #profile_url: student.css('a').attribute('href').value

    students_array = []

    doc = Nokogiri::HTML(open(index_url))

    student_XML = doc.css('.student-card')

    student_XML.each_with_index do |student|
      student_hash = {
        name: student.css('h4').text,
        location: student.css('p').text,
        profile_url: student.css('a').attribute('href').value
      }
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    name = doc.css('h1.profile-name').text
    name_array = name.split(" ")
    first_name = name_array[0]
    last_name = name_array[1]

    student_hash = {
      profile_quote: doc.css('div.profile-quote').text,
      bio: doc.css('div.bio-content.content-holder p').text
    }

    twitter_page = doc.css("div.social-icon-container a[href*='twitter']")
    linkedin_page = doc.css("div.social-icon-container a[href*='linkedin']")
    github_page = doc.css("div.social-icon-container a[href*='github']")
    blog_page_finder = doc.css("div.social-icon-container a")
    blog_page = nil

    blog_page_finder.each do |element| #cycles through all of the a attributes in social-icon-container to find the one that indicates a blog.
      #if an element has an RSS icon as its picture, changes the value of blog_page to that elements anchor link link (not the img link)
      #the rest of the finders could be changed to do this as well.
      if element.children.attribute("src").value == '../assets/img/rss-icon.png'
        blog_page = element.attribute("href").value
      end
    end

    if twitter_page.empty? == false
      student_hash[:twitter] = twitter_page.attribute('href').value
    end

    if linkedin_page.empty? == false
      student_hash[:linkedin] = linkedin_page.attribute('href').value
    end

    if github_page.empty? == false
      student_hash[:github] = github_page.attribute('href').value
    end

    if blog_page != nil
      student_hash[:blog] = blog_page
    end
    student_hash
  end

end
