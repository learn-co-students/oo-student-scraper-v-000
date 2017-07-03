
[1mFrom:[0m /home/sdklos-56703/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 41 Scraper.scrape_profile_page:

    [1;34m24[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m25[0m:   html = open(profile_url)
    [1;34m26[0m:   profile = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m27[0m: 
    [1;34m28[0m:   student = {}
    [1;34m29[0m:   links = []
    [1;34m30[0m: 
    [1;34m31[0m:   profile.css([31m[1;31m"[0m[31m.social-icon-container[1;31m"[0m[31m[0m).each [32mdo[0m |link|
    [1;34m32[0m:     links << link.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).attribute([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m).value
    [1;34m33[0m:   [32mend[0m
    [1;34m34[0m:     [1;34m# linkedin =[0m
    [1;34m35[0m:     [1;34m# github =[0m
    [1;34m36[0m:     [1;34m# blog =[0m
    [1;34m37[0m:     [1;34m# profile_quote =[0m
    [1;34m38[0m:     [1;34m# bio =[0m
    [1;34m39[0m: 
    [1;34m40[0m:   links
 => [1;34m41[0m:   binding.pry
    [1;34m42[0m: 
    [1;34m43[0m:   [1;34m#   student[name.to_sym] = {:linkedin => linkedin, :github => github, :blog => blog, :profile_quote => quote, :bio => bio}[0m
    [1;34m44[0m:     [1;34m# :github=>"https://github.com/learn-co,[0m
    [1;34m45[0m:     [1;34m# :blog=>"http://flatironschool.com",[0m
    [1;34m46[0m:     [1;34m# :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",[0m
    [1;34m47[0m:     [1;34m# :bio=> "I'm a school"[0m
    [1;34m48[0m:   [1;34m# end[0m
    [1;34m49[0m: 
    [1;34m50[0m: 
    [1;34m51[0m: [32mend[0m

