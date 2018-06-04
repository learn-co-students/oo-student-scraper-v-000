
[1mFrom:[0m /home/mrfarmer777/oo-student-scraper-v-000/lib/scraper.rb @ line 39 Scraper.scrape_profile_page:

    [1;34m31[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m32[0m:   html=open(profile_url)
    [1;34m33[0m:   doc=[1;34;4mNokogiri[0m::HTML(html)
    [1;34m34[0m:   stu_hash={}
    [1;34m35[0m:   socials=doc.css([31m[1;31m"[0m[31m.social-icon-container a[1;31m"[0m[31m[0m)
    [1;34m36[0m:   binding.pry
    [1;34m37[0m:   socials.each [32mdo[0m |social|
    [1;34m38[0m:     soc_link=social.attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).text
 => [1;34m39[0m:     binding.pry
    [1;34m40[0m:     [32mcase[0m soc_link
    [1;34m41[0m:     [32mwhen[0m soc_link.include?([31m[1;31m'[0m[31mfacebook[1;31m'[0m[31m[0m)
    [1;34m42[0m:       facebook=soc_link
    [1;34m43[0m:     [32mwhen[0m soc_link.include?([31m[1;31m'[0m[31mlinkedin[1;31m'[0m[31m[0m)
    [1;34m44[0m:       linkedin=soc_link
    [1;34m45[0m:     [32mwhen[0m soc_link.include?([31m[1;31m'[0m[31mtwitter[1;31m'[0m[31m[0m)
    [1;34m46[0m:       twitter=soc_link
    [1;34m47[0m:     [32mwhen[0m soc_link.include?([31m[1;31m'[0m[31mgithub[1;31m'[0m[31m[0m)
    [1;34m48[0m:       github=soc_link
    [1;34m49[0m:     [32melse[0m
    [1;34m50[0m:       blog=soc_link
    [1;34m51[0m:     [32mend[0m
    [1;34m52[0m:     binding.pry
    [1;34m53[0m:   [32mend[0m
    [1;34m54[0m: 
    [1;34m55[0m:   quote=doc.css([31m[1;31m"[0m[31mprofile-quote[1;31m"[0m[31m[0m).text
    [1;34m56[0m:   bio=doc.css([31m[1;31m"[0m[31mdescription-holder p[1;31m"[0m[31m[0m).text
    [1;34m57[0m: 
    [1;34m58[0m:   stu_hash={[35mprofile_quote[0m:quote, [35mbio[0m:bio, [35mtwitter[0m:twitter, [35mgithub[0m:github, [35mblog[0m:blog, [35mlinkedin[0m:linked, [35mfacebook[0m:facebook}
    [1;34m59[0m: [32mend[0m

