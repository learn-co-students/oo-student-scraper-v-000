require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = open(index_url)
    html = Nokogiri::HTML(page)
    arr = html.css('.student-card').collect do |student|
      {
        name: student.css('.student-name').text,
        location: student.css('.student-location').text,
        profile_url: './fixtures/student-site/' + student.css('a')[0]['href']
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = open(profile_url)
    html = Nokogiri::HTML(page)
    attributes = {}
    #add URLs
    html.css('.social-icon-container').css('a').each do |a|
      str = a['href'].gsub("https://", "").gsub("www.", "").gsub("http://", "")
      arr = str.split('.com')
      str = ['twitter', 'linkedin', 'github'].index(arr[0]) != nil ? arr[0] : 'blog'
      attributes[str.to_sym] = a['href']
    end
    #add text
    attributes[:profile_quote] = html.css('.profile-quote').text
    attributes[:bio] = html.css('.bio-content').css('p').text
    #return
    attributes
  end

end
