---
layout: presentation
title: Rfacebook and twitteR
author: Junfei Shen
date: "April 2, 2015"
description: pair presentaion of STAT W4701
tags: R, API, Facebook, Twitter, Leaflet, ggplot, NLP
---

<section>
	<section>
#### Rfacebook

How can we access Facebook API?

<ul>
<li>Upgrade FB account to a developer account <a href="https://developers.facebook.com/">here</a></li>
<li>Create an app, get your App ID and App Secret</li>
<li>library(Rfacebook) in R</li>
<li>Set up your token by caliing fbOAuth(), with your app ID and app secret</li>
<li>Done!</li>
</ul>

</section>
</section>


<section>
	<section>
#### Rfacebook

What can we do with Rfacebook?
Some functions:

<li>getUsers(id, token)</li>
<li>getPage(id, token, n=100)</li>
<li>getPost(id, token, n=500)</li>
<li>searchPages(string, token, n=200)</li>
<li>etc.</li>

</section>
</section>


<section>
	<section>
#### Rfacebook

Get some data with Rfacebook and play around~
<li><a href="http://rpubs.com/shenjunfei">My RPubs</a></li>

</section>
</section>


<section>
	<section>
#### Rfacebook

Heartbreaking facebook API: Some data are no longer be available
<li>getCheckins()</li>
<li>searchFacebook()</li>
<li>getFriends()</li>
<li>getNetwork()</li>
<li>etc.</li>

</section>
</section>


<section>
	<section>
#### twitteR presentation

Rohan Bareja

</section>
</section>


<section>
	<section>
#### Getting Started

#####################################
### CREATING YOUR OWN OAUTH TOKEN ###
#####################################


<li>Step 1: go to <a href="apps.twitter.com">apps.twitter.com</a> and sign in</li>
<li>Step 2: click on "Create New App”</li>
<li>Step 3: fill name, description, and website (it can be anything, even google.com)</li>
<li>Step 4: Agree to user conditions</li>
<li>Step 5: Get consumer key and consumer secret</li>

</section>
</section>


<section>
	<section>
#### Useful Functions

<li>searchTwitter("@BarackObama", 100, lang="en")</li>
<li>getUser</li>
<li>getFollowers</li>
<li>availableTrendLocations</li>
<li>getTrends</li>

</section>
</section>


<section>
	<section>
#### availableTrendLocations()

/images/{r1.png}

</section>
</section>


<section>
	<section>
#### Top trends of NYC (April 1)

getTrends(woeid=2459115)

<li>#CallMeMatt</li>
<li>#Arrow</li>
<li>#KAMustream</li>
<li>#Survivor</li>
<li>#WeAreAllJane</li>

</section>
</section>


<section>
	<section>
#### Things to be discussed today

<li>Word Cloud</li>
<li>Clustering</li>
<li>Sentiment Analysis</li>
<li>Topic Modeling</li>
<li>Networks</li>

</section>
</section>


<section>
	<section>
#### Network of #machinelearning tag

/images/{r2.png}

</section>
</section>
