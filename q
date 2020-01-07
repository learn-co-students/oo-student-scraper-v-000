
[1mFrom:[0m /home/lhwall/oo-student-scraper-v-000/lib/scraper.rb @ line 45 Scraper.scrape_profile_page:

    [1;34m21[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m22[0m:   html = open(profile_url)
    [1;34m23[0m:   document = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m24[0m:   student_hash = [1;34;4mHash[0m.new
    [1;34m25[0m: 
    [1;34m26[0m:   i = [1;34m1[0m
    [1;34m27[0m:   [32mwhile[0m i <= [1;34m8[0m
    [1;34m28[0m:   [32mif[0m document.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m)[i] != [1;36mnil[0m
    [1;34m29[0m:   current_link = document.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m)[i][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m30[0m:     [32mif[0m current_link.match([35m[1;35m/[0m[35m.*twitter.com.*[1;35m/[0m[35m[0m) 
    [1;34m31[0m:       student_hash[[33m:twitter[0m] = current_link
    [1;34m32[0m:     [32melsif[0m current_link.match([35m[1;35m/[0m[35m.*linkedin.com.*[1;35m/[0m[35m[0m) 
    [1;34m33[0m:       student_hash[[33m:linkedin[0m] = current_link
    [1;34m34[0m:     [32melsif[0m current_link.match([35m[1;35m/[0m[35m.*github.com.*[1;35m/[0m[35m[0m) 
    [1;34m35[0m:       student_hash[[33m:github[0m] = current_link
    [1;34m36[0m:     [32melse[0m 
    [1;34m37[0m:       student_hash[[33m:blog[0m] = document.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m)[i][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m38[0m:     [32mend[0m 
    [1;34m39[0m:   [32mend[0m 
    [1;34m40[0m:     i += [1;34m1[0m
    [1;34m41[0m: [32mend[0m 
    [1;34m42[0m:   student_hash[[33m:profile_quote[0m] = document.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text
    [1;34m43[0m:   student_hash[[33m:bio[0m] = document.css([31m[1;31m"[0m[31mp[1;31m"[0m[31m[0m)[[1;34m0[0m].text
    [1;34m44[0m:   student_hash
 => [1;34m45[0m:   binding.pry
    [1;34m46[0m: [32mend[0m

