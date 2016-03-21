require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css('.roster-cards-container .student-card').each do |student|
      students << {
        name: student.css('a .card-text-container h4.student-name').text,
        location: student.css('a .card-text-container p.student-location').text,
        profile_url: "http://127.0.0.1:4000/#{student.css('a').attribute('href').value}"
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {
      profile_quote: profile_page.css('.profile-quote').text,
      bio: profile_page.css('.bio-content .description-holder p').text
    }

    # Iterate through social icons and grab any links to twitter, linkedin
    # github or their blog (rss).
    profile_page.css('.social-icon-container a').each do |link|
      link_href = link.attribute('href').value
      link_img_src = link.css('img').attribute('src').value
      if link_img_src[/twitter/]
        student[:twitter] = link_href
      elsif link_img_src[/linkedin/]
        student[:linkedin] = link_href
      elsif link_img_src[/github/]
        student[:github] = link_href
      elsif link_img_src[/rss/]
        student[:blog] = link_href
      end
    end
    student
  end

end
