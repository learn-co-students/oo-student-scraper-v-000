require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html=open(index_url)
    studentPage=Nokogiri::HTML(html)

    students=[]
    studentPage.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/" + student.css("a").attribute("href").value
        }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    result={}
    result[:profile_quote] = profile.css('div.profile-quote').text
    result[:bio] = profile.css('.bio-content .description-holder p').text
    profile.css('div.social-icon-container a').each do |href|
      link = href.attribute('href').value
      if link.match(/.linkedin.com/)
        result[:linkedin] = link
      elsif link.match(/.twitter.com/)
        result[:twitter] = link
      elsif link.match(/.github.com/)
        result[:github] = link
      else
        result[:blog] = link
      end
    end
    result
  end

end
