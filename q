
[1mFrom:[0m /home/ubuntu/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 32 Scraper.scrape_profile_page:

    [1;34m20[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m21[0m:   html = [1;36mself[0m.get_html(profile_url)
    [1;34m22[0m: 
    [1;34m23[0m:   student = {
    [1;34m24[0m:     [33m:profile_quote[0m => html.css([31m[1;31m"[0m[31mdiv.profile-quote[1;31m"[0m[31m[0m).text.strip,
    [1;34m25[0m:     [33m:bio[0m => html.css([31m[1;31m"[0m[31mdiv.bio-content div.description-holder[1;31m"[0m[31m[0m).text.gsub([35m[1;35m/[0m[35m[1;35m\n[0m[35m[1;35m/[0m[35m[0m, [31m[1;31m"[0m[31m[1;31m"[0m[31m[0m).strip
    [1;34m26[0m:   }
    [1;34m27[0m:   
    [1;34m28[0m:   social_links = [1;36mself[0m.get_social_links(html)
    [1;34m29[0m:  
    [1;34m30[0m:   social_keys = [1;36mself[0m.get_social_keys(html)
    [1;34m31[0m:   
 => [1;34m32[0m:   binding.pry
    [1;34m33[0m:   
    [1;34m34[0m:   counter = [1;34m0[0m
    [1;34m35[0m:   [32mwhile[0m counter < social_links.length
    [1;34m36[0m:       student[social_keys[counter].to_sym] = social_links[counter]
    [1;34m37[0m:       counter += [1;34m1[0m
    [1;34m38[0m:   [32mend[0m
    [1;34m39[0m:     
    [1;34m40[0m:   student
    [1;34m41[0m:       
    [1;34m42[0m: [32mend[0m

