require 'open-uri'
require 'pry'


class Scraper
  attr_reader :attribute
  attr_accessor :students, :name, :location , :profile_url


def self.scrape_index_page(index_url)
  @students = []

  hash_array = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
      students_array = hash_array.css(".student-card").collect do |student|
      @name = student.css("h4.student-name").text
      @location = student.css("p.student-location").text
      @profile_url = student.css("a").attribute("href").value
      student =
        {:name => @name,
        :location => @location,
        :profile_url => @profile_url
        }
      @students << student
        # binding.pry
  end
      @students
      # binding.pry
  end

  def self.scrape_profile_page(profile_url)
     student = {}
     self.scrape_index_page("./fixtures/student-site/index.html")
     profile_url = @students.collect do |student|
       student[:profile_url].to_s
       profile_url
     end
  profile_url.each do |profile|
    page = Nokogiri::HTML(open(profile))

    page.css("div.vitals-container").each do |first|
    # name = first.css("div.vitals-text-container h1.profile-name").text
          #  binding.pry

          value_1 = first.css("div.social-icon-container a")[0].attribute("href").value
          if value_1.include?("twitter")
              twitter = value_1
          elsif value_1.include?("linkedin")
            linkedin = value_1
          elsif value_1.include?("github")
            github = value_1
          else value_1.include?(first.css("div.vitals-text-container h1.profile-name").text)
            blog = value_1
          end
        if first.css("div.social-icon-container a")[1]
          value_2 = first.css("div.social-icon-container a")[1].attribute("href").value
          if value_2.include?("twitter")
              twitter = value_2
          elsif value_2.include?("linkedin")
             linkedin = value_2
          elsif value_2.include?("github")
             github = value_2
          else value_2.include?(first.css("div.vitals-text-container h1.profile-name").text)
           blog = value_2
          end
        end

          if first.css("div.social-icon-container a")[2]
          value_3 = first.css("div.social-icon-container a")[2].attribute("href").value
          if value_3.include?("twitter")
             twitter = value_3
          elsif value_3.include?("linkedin")
            linkedin = value_3
          elsif value_3.include?("github")
             github = value_3
          else value_3.include?(first.css("div.vitals-text-container h1.profile-name").text)
             blog = value_3
          end
        end
        if first.css("div.social-icon-container a")[3]
          value_4 = first.css("div.social-icon-container a")[3].attribute("href").value
          if value_4.include?("twitter")
             twitter = value_4
          elsif value_4.include?("linkedin")
             linkedin = value_4
          elsif value_4.include?("github")
             github = value_4
          else value_4.include?(first.css("div.vitals-text-container h1.profile-name").text)
            blog = value_4
          end
        end


        # twitter = first.css("div.social-icon-container a")[0].attribute("href").value
        # linkedin = first.css("div.social-icon-container a")[1].attribute("href").value
        # github = first.css("div.social-icon-container a")[2].attribute("href").value
        # blog = first.css("div.social-icon-container a")[3].attribute("href").value
         profile_quote = first.css("div.profile-quote").text
        bio = page.css("div.details-container").css("div.description-holder p").text

      student[:twitter] = twitter
      student[:linkedin] = linkedin
      student[:github] = github
      student[:blog] = blog
      student[:profile_quote] = profile_quote
      student[:bio] = bio
      # binding.pry

    student.delete_if {|key, value| value == nil }
    end
  end
  student
end
end


# ./fixtures/student-site/students/joe-burgess.html
