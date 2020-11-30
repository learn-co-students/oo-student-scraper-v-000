
[1mFrom:[0m /home/Ceci2222/oo-student-scraper-v-000/lib/scraper.rb @ line 34 Scraper.scrape_profile_page:

    [1;34m21[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m22[0m:   student = {}
    [1;34m23[0m:   profile = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m24[0m: 
    [1;34m25[0m:   profile.css([31m[1;31m'[0m[31mdiv.social-icon-container a[1;31m'[0m[31m[0m).map [32mdo[0m |link|
    [1;34m26[0m:     [32mif[0m link.values.to_s.include?([31m[1;31m'[0m[31mtwitter[1;31m'[0m[31m[0m)
    [1;34m27[0m:       student[[33m:twitter[0m] = [31m[1;31m"[0m[31m#{link}[0m[31m[1;31m"[0m[31m[0m 
    [1;34m28[0m:     [32melsif[0m link.values.to_s.include?([31m[1;31m'[0m[31mlinkedin[1;31m'[0m[31m[0m)
    [1;34m29[0m:       student[[33m:linkedin[0m]
    [1;34m30[0m:     [32melsif[0m link.values.to_s.include?([31m[1;31m'[0m[31mgithub[1;31m'[0m[31m[0m)
    [1;34m31[0m:     [32mend[0m
    [1;34m32[0m:   [32mend[0m
    [1;34m33[0m:   student
 => [1;34m34[0m:   binding.pry
    [1;34m35[0m:       
    [1;34m36[0m:       
    [1;34m37[0m:     
    [1;34m38[0m:     [1;34m# student[:twitter] = "#{link}" if link.values.include?('twitter') [0m
    [1;34m39[0m:     [1;34m# student[:linkedin] = "#{link}" if link.values.include?('linkedin')[0m
    [1;34m40[0m:     [1;34m# student[:github] = "#{link}" if link.values.include?('github')[0m
    [1;34m41[0m:   [1;34m# end[0m
    [1;34m42[0m:   student
    [1;34m43[0m:   [1;34m# binding.pry[0m
    [1;34m44[0m:   
    [1;34m45[0m: [32mend[0m

