require 'open-uri'
require 'pry'
require 'nokogiri'

# index page: http://127.0.0.1:4000/
# profile page: http://127.0.0.1:4000/students/[first]-[last].html



class Scraper

  def self.scrape_index_page(index_url)

    student_array = []   # arry of student hashes (keys :name :location :profile_url)
    source = Nokogiri::HTML(open(index_url))

    source.css('.student-card').each do |student|
      profile_url = index_url + student.css('a').attribute('href').text
      name = student.css('h4').text
      location = student.css('p').text
      student_hash={ :name=>name, :location=>location, :profile_url=>profile_url}
      student_array << student_hash
    end

    student_array
    binding.pry
  end


  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    source = Nokogiri::HTML(open(profile_url))

    source.css('.social-icon-container').css('a').each do |social_link|
      icon = ':' + social_link.css('img').attribute('src').text.scan(/(?<=^\.\.\/assets\/img\/)(.*)(?=[$\-])/).flatten.join
      icon == ':rss' ? icon = ':blog' : icon
      link = social_link.attribute('href').text
      profile_hash[icon] = link
    end

    profile_hash[:profile_quote] = source.css('.profile-quote').text
    profile_hash[:bio] = source.css('.description-holder').css('p').text

    profile_hash
  end

end



#index_scrape = Scraper.scrape_index_page('http://127.0.0.1:4000/')

#profile_scrape = Scraper.scrape_profile_page('http://127.0.0.1:4000/students/ryan-johnson.html')
#profile_scrape = Scraper.scrape_profile_page('http://127.0.0.1:4000/students/eric-chu.html')

#binding.pry
