require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
  #  html = (open("http://165.227.31.208:57678/fixtures/student-site/"))
    html = (open(index_url))
    doc = Nokogiri::HTML(html)
    student_profiles = []
    student_info = doc.css(".student-card")
      student_info.collect do |profile|
          student_profile = {}
          student_profile[:name] =  profile.css('.card-text-container .student-name').text
          student_profile[:location] = profile.css('.card-text-container .student-location').text
          student_profile[:profile_url] = profile.css('a').first.attribute('href').value

          student_profiles << student_profile
        end
        student_profiles
      end

  def self.scrape_profile_page(profile_url)
    html = (open("http://165.227.16.205:46452/fixtures/student-site/students/matt-preiser.html"))
    doc = Nokogiri::HTML(html)
    student_links = []
    student_data = {}
      doc.css('.social-icon-container a').each do |link|
      if link.attributes['href'].value.include?("twitter")
            student_data[:twitter] = link.attributes['href'].value
      end
      if link.attributes['href'].value.include?("linkedin")
            student_data[:linkedin] = link.attributes['href'].value
      if  link.attributes['href'].value.include?("github")
           student_data[:github] = link.attributes['href'].value
        end
      end

        binding.pry

      end



    # linkedin = doc.css('social-icon-container a')
    # github =
    # blog =
    # profile_quote = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    # bio = doc.css(".description-holder p").text

  end

end
