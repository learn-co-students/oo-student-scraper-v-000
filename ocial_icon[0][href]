
[1mFrom:[0m /home/felix-89479/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 26 Scraper.scrape_profile_page:

    [1;34m17[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m18[0m:   page = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m19[0m:   social_icons = page.css([31m[1;31m"[0m[31m.social-icon-container a[1;31m"[0m[31m[0m)
    [1;34m20[0m:   twitter = [31m[1;31m"[0m[31m[1;31m"[0m[31m[0m
    [1;34m21[0m:   linkedin = [31m[1;31m"[0m[31m[1;31m"[0m[31m[0m
    [1;34m22[0m:   github = [31m[1;31m"[0m[31m[1;31m"[0m[31m[0m
    [1;34m23[0m:   blog = [31m[1;31m"[0m[31m[1;31m"[0m[31m[0m
    [1;34m24[0m:   social_icons.each [32mdo[0m |social_icon|
    [1;34m25[0m:     [32mif[0m social_icon.css([31m[1;31m"[0m[31mimg[1;31m"[0m[31m[0m)[[1;34m0[0m][[31m[1;31m"[0m[31msrc[1;31m"[0m[31m[0m] == [31m[1;31m"[0m[31m../assets/img/twitter-icon.png[1;31m"[0m[31m[0m
 => [1;34m26[0m:       binding.pry
    [1;34m27[0m:       twitter = social_icon[[1;34m0[0m][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m28[0m:     [32melsif[0m social_icon.css([31m[1;31m"[0m[31mimg[1;31m"[0m[31m[0m)[[1;34m0[0m][[31m[1;31m"[0m[31msrc[1;31m"[0m[31m[0m] == [31m[1;31m"[0m[31m../assets/img/linkedin-icon.png[1;31m"[0m[31m[0m
    [1;34m29[0m:       linkedin = social_icon[[1;34m0[0m][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m30[0m:     [32melsif[0m social_icon.css([31m[1;31m"[0m[31mimg[1;31m"[0m[31m[0m)[[1;34m0[0m][[31m[1;31m"[0m[31msrc[1;31m"[0m[31m[0m] == [31m[1;31m"[0m[31m../assets/img/github-icon.png[1;31m"[0m[31m[0m
    [1;34m31[0m:       github = social_icon[[1;34m0[0m][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m32[0m:     [32melsif[0m social_icon.css([31m[1;31m"[0m[31mimg[1;31m"[0m[31m[0m)[[1;34m0[0m][[31m[1;31m"[0m[31msrc[1;31m"[0m[31m[0m] == [31m[1;31m"[0m[31m../assets/img/rss-icon.png[1;31m"[0m[31m[0m
    [1;34m33[0m:       blog = social_icon[[1;34m0[0m][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m]
    [1;34m34[0m:     [32mend[0m
    [1;34m35[0m:   [32mend[0m
    [1;34m36[0m:   {
    [1;34m37[0m:     [35mtwitter[0m: twitter,
    [1;34m38[0m:     [35mlinkedin[0m: linkedin,
    [1;34m39[0m:     [35mgithub[0m: github,
    [1;34m40[0m:     [35mblog[0m: blog,
    [1;34m41[0m:     [35mprofile_quote[0m: page.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text,
    [1;34m42[0m:     [35mbio[0m: page.css([31m[1;31m"[0m[31m.bio-content .description-holder p[1;31m"[0m[31m[0m).text
    [1;34m43[0m:   }
    [1;34m44[0m: [32mend[0m

