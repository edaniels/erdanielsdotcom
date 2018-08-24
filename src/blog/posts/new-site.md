date=2015-05-25T18:53:32-04:00
title=How I Saved Money with Static Site Generation
template=templates/blog_post.html



I've had the same blog running on WordPress for years. My hosting provider has also been the same for a while ([A Small Orange Hosting](https://asmallorange.com/)). While both are great solutions for getting a blog up and running, I am trying to optimize for costs in all aspects of life. First it was my phone bill, and then my gym which both save me about $150 a month. Now it is this site's turn. I decided to do this over this weekend because my domain was up for renewal.

<!--more-->

## WordPress -> Hugo

For a while I knew I wanted a static site but I didn't know what solution I wanted to choose. I ended up going with [hugo](https://gohugo.io) since I've been working with go lately. The fact that it's in go doesn't mean much to me since I am not working on hugo; I'm just using it. It's a simple framework that lets me do the only thing I need to do, get blog posts up quickly. Furthermore, it's static. I've never had any kind of content on my site that needs to be loaded dynamically. Getting hugo set up was painless; getting a theme customized to my liking took a little longer but was still straightforward.

## ASO -> AWS

ASO wasn't really costing me much money a year but next year it would have cost me about $36 to run my simple site. I decided to get a free tier subscription on AWS since this would give me a whole year for free. A t2.micro is all I need for a site like this. It gets very few hits and needs barely any CPU power to function. After this year, I will invest some time into spot instances and see if a t1.micro will suit the site.

## HTTP -> HTTPS & HTTP/2

This part has nothing to do with saving money and more with being an early adopter. I heard about [H2O](https://github.com/h2o/h2o) on Hacker News and I recalled it having HTTP/2 support. I decided to give it a go and it was a piece of cake to get the server up and running with a new SSL cert and serving HTTP/2 if clients ask for it. This also allowed me to get an A+ on the [Qualys SSL Server Test](https://www.ssllabs.com/ssltest/analyze.html?d=erdaniels.com). The site doesn't need to be secure but it's nice to be secure by default.

## Conclusion
This was a pretty simple move that will save me (excluding SSL) about $7-9 on hosting my site. I could have also chosen to host the site on GitHub Pages or on some other free hosting but this was a nice way to try some new software out.

If you want to see the configuration of this site and the code running it, check out the repo at [https://github.com/edaniels/erdanielsdotcom-config](https://github.com/edaniels/erdanielsdotcom-config)