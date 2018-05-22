require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    students.each {|s|
    profiles << {:name => s.css('h4').text, :location => s.css('p').text, :profile_url => s.css('a')[0]['href']}}
    profiles
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    profile_urls = "./fixtures/student-site/students/kris-henderson.html"
    doc = Nokogiri::HTML(open(profile_urls))
    links = []
    doc.css('div.social-icon-container a').each {|link| links << link['href']}
      linkedin = links.detect {|l| l.include?"linkedin"}
      github = links.detect {|l| l.include?"github"}
      twitter  = links.detect {|l| l.include?"twitter"}
      blog = links.detect {|l| l != linkedin && l != github && l != twitter}
      binding.pry
      
      #l = xpath("a[contains(@href, 'linkedin')]")[0]['href']
      #g = links.xpath("a[contains(@href, 'github')]")[0]['href']
      #b = links.xpath("a[contains(@href, 'http:')]")[0]['href']
      #t = links.xpath("a[contains(@href, 'twitter')]")[0]['href']
      
        profile[:linkedin] = linkedin if linkedin != nil
        profile[:blog] = blog if blog != nil
        profile[:twitter] = twitter if twitter !=nil
        profile[:profile_quote] = doc.css('div.profile-quote').text
        profile[:bio] = doc.css('div.description-holder p').text
        
    
  end

end