require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


    def self.scrape_index_page(index_url)
        html = open(index_url)
        doc = Nokogiri::HTML(html)

            student_page = {}

        doc.css("div.student-card").map do |project| #individual section for each student).map do |project|

              student_page = { 
              :name => project.css("div.card-text-container h4.student-name").text,
              :location => project.css("div.card-text-container p.student-location").text,
              :profile_url => "http://127.0.0.1:4000/" + project.css("a").attr("href").value
              }
        end        

    end

#     def self.scrape_profile_page(profile_url)
     
#         html = open(profile_url)
#         doc = Nokogiri::HTML(html)

#         student_profile = {}

#         doc.css("div.vitals-container").each do |profile|

#           student_profile = { 

#             :twitter => profile.css("div.social-icon-container a").attr("href").value,
#             :linkedin => profile.css("div.social-icon-container a:nth-child(2)").attr("href").value,
#             :github => profile.css("div.social-icon-container a:nth-child(3)").attr("href").value,
#             :blog => profile.css("div.social-icon-container a:nth-child(4)").attr("href").value,
#             :profile_quote => profile.css("div.profile-quote").text,    
#             :bio => doc.css("div.details-container").each do |profile2|
#                  profile2.css("div.description-holder p").text
#              }
#             end
#             end

#           puts student_profile
#     end



# end

# Scraper.scrape_profile_page("http://127.0.0.1:4000/students/ryan-johnson.html")

  def self.scrape_profile_page(profile_url)

      html = open(profile_url)
      doc = Nokogiri::HTML(html)

          result = {}

          doc.css("div.vitals-container").each do |profile| 

              profile.css("div.social-icon-container a").each do |social|

                  if social.attribute("href").value.include?("twitter") 
                  
                      result[:twitter] = social.attribute("href").value 

                  end

                end

                # :nth-child(2)

                profile.css("div.social-icon-container a").each do |social2| 

                  if social2.attribute("href").value.include?("linkedin")

                      result[:linkedin] = social2.attribute("href").value

                  end

                end

                profile.css("div.social-icon-container a").each do |social3|

                  if social3.attribute("href").value.include?("github")

                      result[:github] = social3.attribute("href").value
                    
                  end

                end

                profile.css("div.social-icon-container a").each do |social4|

                  if !social4.attribute("href").value.include?("github") && !social4.attribute("href").value.include?("linkedin") && !social4.attribute("href").value.include?("twitter") && social4.attribute("href").value   

                    result[:blog] = social4.attribute("href").value

                  end

                end

                  if profile.css("div.profile-quote").text != nil || profile.css("div.profile-quote").text != ""

                    result[:profile_quote] = profile.css("div.profile-quote").text

                  end

          end

          doc.css("div.details-container").each do |social5|

                  if social5.css("div.description-holder p").text != nil || social5.css("div.description-holder p").text != ""  
#                  
                    result[:bio] = social5.css("div.description-holder p").text

                  end 

          end 


           result 

  end

  end 



                # if social.attribute("href").value != nil 

                #     result[:blog] = profile.css("div.social-icon-container a:nth-child(4)").attr("href").value

                # end 


              
              # :twitter => profile.css("div.social-icon-container a").attr("href").value, 
              # :linkedin => profile.css("div.social-icon-container a:nth-child(2)").attr("href").value,
              # :github => profile.css("div.social-icon-container a:nth-child(3)").attr("href").value, 
              # :blog => profile.css("div.social-icon-container a:nth-child(4)").attr("href").value.nil? ? "" , profile.css("div.social-icon-container a:nth-child(4)").attr("href").value
              
              # :profile_quote => profile.css("div.profile-quote").text


# profile.css("div.social-icon-container a").each do |social|
#       if social.attribute("href").value.to_s.include?("twitter")
