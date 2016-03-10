
############################
  def initialize(student_hash)
    student = {
    :name => name,
    :location => location,
    :twitter => twitter,
    :linkedin => linkedin,
    :github => github,
    :blog => blog,
    :profile_quote => profile_quote,
    :bio => bio,
    :profile_url => profile_url
    }
    @@all << student
  end
############################

    profiles_hash << {
    twitter: i.css("a")[1]["href"] unless twitter.empty?,
    linkedin: i.css("a")[2]["href"] unless linkedin.empty?,
    github: i.css("a")[3]["href"]unless github.empty?,
    blog: i.css("a")[4]["href"] unless blog.empty?,
    profile_quote: i.css("div.profile-quote").text,
    bio: i.css("div.description-holder p").text
    }

############################
############################

      profile_hash["twitter"] = i.css("a")[1]["href"],
      profile_hash["linkedin"] = i.css("a")[2]["href"]

      # profile_hash["github"] = i.css("a")[3]["href"]
      # profile_hash["blog"] = i.css("a")[4]["href"]
      # profile_hash["profile_quote"] = i.css("div.profile-quote").text
      # profile_hash["bio"] = i.css("div.description-holder p").text
      # binding.pry
      profiles << profile_hash
      binding.pry



Scraper.scrape_profile_page(profile_url)
# => {:twitter=>"http://twitter.com/flatironschool",
      :linkedin=>"https://www.linkedin.com/in/flatironschool",
      :github=>"https://github.com/learn-co,
      :blog=>"http://flatironschool.com",
      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      :bio=> "I'm a school"
     } 




     {name = "a",
        attributes = 
            [#(Attr:0x3fdb1dcac6b8 {name = "href", value = "http://joemburgess.com/" })],
      children = 
  [#(Element:0x3fdb1e50646c {name = "img",  

  attributes = 
  [#(Attr:0x3fdb1e4ff324 {name = "class", value = "social-icon" }),
   #(Attr:0x3fdb1e4ff310 {name = "src", value = "../assets/img/rss-icon.png" })]
      })]
  })