
[1mFrom:[0m /home/dbfarms/oo-student-scraper-v-000/lib/scraper.rb @ line 57 Scraper.scrape_profile_page:

    [1;34m31[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m32[0m:   html = [1;34;4mFile[0m.read(profile_url)
    [1;34m33[0m:   student_profile = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m34[0m: 
    [1;34m35[0m:   student = {}
    [1;34m36[0m:   [1;34m#binding.pry[0m
    [1;34m37[0m: 
    [1;34m38[0m:   social_links = student_profile.css([31m[1;31m"[0m[31mdiv.social-icon-container[1;31m"[0m[31m[0m).children.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).map {|link_check| link_check.attribute([31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m).value}
    [1;34m39[0m:     [1;34m#binding.pry[0m
    [1;34m40[0m:     social_links.each [32mdo[0m |link|
    [1;34m41[0m:       [32mif[0m link.include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m)
    [1;34m42[0m:         student[[33m:linkedin[0m] = link
    [1;34m43[0m:       [32melsif[0m link.include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m44[0m:         student[[33m:github[0m] = link
    [1;34m45[0m:       [32melsif[0m link.include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m46[0m:         student[[33m:twitter[0m] = link
    [1;34m47[0m:       [32melse[0m
    [1;34m48[0m:         student[[33m:blog[0m] = link
    [1;34m49[0m:       [32mend[0m
    [1;34m50[0m:     [32mend[0m
    [1;34m51[0m:     [1;34m#binding.pry[0m
    [1;34m52[0m: 
    [1;34m53[0m:     student[[33m:profile_quote[0m] = student_profile.css([31m[1;31m"[0m[31mdiv.vitals-text-container div.profile_quote[1;31m"[0m[31m[0m)
    [1;34m54[0m:     student[[33m:bio[0m] = student_profile.css([31m[1;31m"[0m[31mdiv.details-container p[1;31m"[0m[31m[0m)
    [1;34m55[0m: 
    [1;34m56[0m:   student
 => [1;34m57[0m:   binding.pry
    [1;34m58[0m: [32mend[0m

