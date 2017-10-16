require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students=Nokogiri::HTML(html)
    student_list=[]

    students.css('.student-card').each do |student|
      student_hash={}

      student_hash[:name]= student.css('h4').text
     student_hash[:location]=student.css("p.student-location").text
     student_hash[:profile_url]=student.css("a").first.attributes["href"].value

      student_list<<student_hash
    end
    student_list
  end




  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_info=Nokogiri::HTML(html)

    social_media_url_array= student_info.css('.social-icon-container').css('a').collect do |social_media|
      social_media.attributes["href"].value
    end
    individual_student_hash={}

    if social_media_url_array.length ==4


      individual_student_hash[:twitter]=social_media_url_array[0]
      individual_student_hash[:linkedin]=social_media_url_array[1]
      individual_student_hash[:github]=social_media_url_array[2]
      individual_student_hash[:blog]=social_media_url_array[3]

    else
      number_of_social_media_links = social_media_url_array.length
      

      if social_media_url_array[0].include?("twitter")
        individual_student_hash[:twitter]=social_media_url_array[0]
        number_of_social_media_links -=1
        if number_of_social_media_links > 1
          if social_media_url_array[1].include?("linkedin")
            individual_student_hash[:linkedin]=social_media_url_array[1]
            number_of_social_media_links -=1
          elsif social_media_url_array[1].include?("github")
            individual_student_hash[:github]=social_media_url_array[1]
            number_of_social_media_links -=1
          else
            individual_student_hash[:blog]=social_media_url_array[1]
            number_of_social_media_links -=1
          end
        end

      elsif social_media_url_array[0].include?("linkedin")
        individual_student_hash[:linkedin]=social_media_url_array[0]
        number_of_social_media_links -=1
      elsif social_media_url_array[0].include?("github")
        individual_student_hash[:github]=social_media_url_array[0]
        number_of_social_media_links -=1
      else
        individual_student_hash[:blog]=social_media_url_array[0]
        number_of_social_media_links -=1
      end

      if social_media_url_array[1].include?("linkedin")
        individual_student_hash[:linkedin]=social_media_url_array[1]
        number_of_social_media_links -=1
      elsif social_media_url_array[1].include?("github")
        individual_student_hash[:github]=social_media_url_array[1]
        number_of_social_media_links -=1
      end

      if number_of_social_media_links >0
        individual_student_hash[:blog]=social_media_url_array[2]
      end

    end


#twitter_url = x.css('.social-icon-container').css('a').attributes["href"].value
#linkedin_url
#github_url
#blog_url
#profile_quote
#bio
individual_student_hash[:profile_quote]=student_info.css('div.profile-quote').text
individual_student_hash[:bio]=student_info.css('p').text

  individual_student_hash
  end

end
