---
layout: pres
title: Yelp API
author: Yu Tian
date: "March 31, 2015"
description: pair presentaion
tags: R, python, Yelp API, ggmap, rMaps, Leaflet, ggplot, presentation
---

<section>
	<section>
#### Yelp API in Python

Code samples and data visualization

![](https://s3-media1.fl.yelpassets.com/assets/2/www/img/279dca8060b5/developers/top_shelf/api.png)]

</section>
</section>



<section>
	<section>
#### I. Introduction - Get started
<H4>* [Click](https://www.yelp.com/developers) to become a yelp developer</H4>

<H4>* Get your [API Access](https://www.yelp.com/developers/documentation/v2/authentication)</H4>
<ul>
Yelp uses OAuth 1.0a for authenticating API requests
<li>consumer key</li>
<li>consumer secret</li>
<li>token</li>
<li>token secret</li>

You're all set!
</ul>
</section>
  <section>
#### I. Introduction - Yelp Open Source
<H4>Awesome Resources!</H4>
  <li>Yelp's [GitHub](https://github.com/Yelp/yelp-api/)</li>
  <li>Check out code samples for languages of your own liking [here](https://github.com/Yelp/yelp-api/tree/master/v2)</li>

</section>
  <section>
#### I. Introduction - Yelp API
<H4>Two basic features: Businese API</H4>
<H5>[Businese API](https://www.yelp.com/developers/documentation/v2/business)</H5>
  <li>Input: businese id</li>
  <li>Output: businese information</li>
<H5>[Search API](https://www.yelp.com/developers/documentation/v2/search_api)</H5>
  <li>Input: search keywords (parameters) </li>
  <li>Output: search result</li>
</section>
</section>


<section>
  <section>
#### II. Demo in python - build my own functions
See my code [here]()
<H4>1. The very fundamental componet: "request"</H4>
<li>Send your request to yelp by passing a url that points to the object.</li>
<H4>2. Feature A: "get _ business" </H4>
<li>Tell me the business id, I'll give you the information I allow you to see.</li>
Call: get _ business('upstate-new-york-2')
Returned:
<div class="island code-sample">
        <pre>{ 
  u'categories': [ [u'American (New)', u'newamerican'],
                   [u'Seafood', u'seafood']],
  u'display_phone': u'+1-917-408-3395',
  u'id': u'upstate-new-york-2',
  u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/RuzizPitO3wvIUJRyhZ5MA/ms.jpg',
  u'is_claimed': True,
  u'is_closed': False,
  u'location': { u'address': [u'95 1st Ave'],
                 u'city': u'New York',
                 u'coordinate': { u'latitude': 40.7263139141197,
                                  u'longitude': -73.9864901976935},
                 u'country_code': u'US',
                 u'display_address': [ u'95 1st Ave',
                                       u'East Village',
                                       u'New York, NY 10003'],
                 u'geo_accuracy': 9.5,
                 u'neighborhoods': [u'East Village'],
                 u'postal_code': u'10003',
                 u'state_code': u'NY'},
  u'menu_date_updated': 1416597147,
  u'menu_provider': u'single_platform',
  u'mobile_url': u'http://m.yelp.com/biz/upstate-new-york-2',
  u'name': u'Upstate',
  u'phone': u'9174083395',
  u'rating': 4.5,
  u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png',
  u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png',
  u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png',
  u'review_count': 872,
  u'reviews': [ { u'excerpt': u"I never give 5 stars. I always think it will look more authentic if I put four. I can't not give this place five stars. It was the most incredible...",
                  u'id': u'07jS75P1-pviQ_3zPNYqkQ',
                  u'rating': 5,
                  u'rating_image_large_url': u'http://s3-media3.fl.yelpassets.com/assets/2/www/img/22affc4e6c38/ico/stars/v1/stars_large_5.png',
                  u'rating_image_small_url': u'http://s3-media1.fl.yelpassets.com/assets/2/www/img/c7623205d5cd/ico/stars/v1/stars_small_5.png',
                  u'rating_image_url': u'http://s3-media1.fl.yelpassets.com/assets/2/www/img/f1def11e4e79/ico/stars/v1/stars_5.png',
                  u'time_created': 1426989529,
                  u'user': { u'id': u'FA-X9QZ5ATMbpPIKSFefKw',
                             u'image_url': u'http://s3-media4.fl.yelpassets.com/photo/dlu2wYiYysLbt5sdjiXbbA/ms.jpg',
                             u'name': u'Alyssa B.'}}],
  u'snippet_image_url': u'http://s3-media4.fl.yelpassets.com/photo/dlu2wYiYysLbt5sdjiXbbA/ms.jpg',
  u'snippet_text': u"I never give 5 stars. I always think it will look more authentic if I put four. I can't not give this place five stars. It was the most incredible...",
  u'url': u'http://www.yelp.com/biz/upstate-new-york-2'}
</pre>
    </div>
</section>
### II. Demo in python - build my own function
See my code [here]()
<H4>3. Feature B: "search"</H4>
  <li>Highly customizable </li>
  <li>Give me any of [these](https://www.yelp.com/developers/documentation/v2/search_api) search parameters, I'll give you a summary information about businesses in this region.</li>
Call: search('bar','San Francisco, CA')
Returned:
<div class="island code-sample">
        <pre>
{u'region': {u'span': {u'latitude_delta': 0.0, u'longitude_delta': 0.0}, 
             u'center': {u'latitude': 37.7899538528782, u'longitude': -122.411338984966}
             }, 
 u'total': 6725, 
 u'businesses': [{u'is_claimed': False, 
                  u'rating': 4.5, 
                  u'mobile_url': u'http://m.yelp.com/biz/hopwater-distribution-san-francisco', 
                  u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', 
                  u'review_count': 251, 
                  u'name': u'Hopwater Distribution', 
                  u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', 
                  u'url': u'http://www.yelp.com/biz/hopwater-distribution-san-francisco', 
                  u'is_closed': False, 
                  u'snippet_text': u"Oh sweet heavens to Betsy! This place is my new fave beer and grub refuge. Ya know when you're craving a delicious burger and a cold IPA? This joint is THE...", 
                  u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/UkWsSo0tQWJM2wp4yEEUag/ms.jpg', u'categories': [[u'Pubs', u'pubs'], [u'American (Traditional)', u'tradamerican']], 
                  u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', 
                  u'id': u'hopwater-distribution-san-francisco', 
                  u'snippet_image_url': u'http://s3-media3.fl.yelpassets.com/photo/rJAwjFcyD2JGgGJCLj6n-A/ms.jpg', 
                  u'location': {u'cross_streets': u'Taylor St & Mason St', 
                                u'city': u'San Francisco', 
                                u'display_address': [u'850 Bush St', u'Nob Hill', u'San Francisco, CA 94108'], 
                                u'geo_accuracy': 9.5, 
                                u'neighborhoods': [u'Nob Hill', u'Union Square', u'Lower Nob Hill'], 
                                u'postal_code': u'94108', 
                                u'country_code': u'US', 
                                u'address': [u'850 Bush St'], 
                                u'coordinate': {u'latitude': 37.7899538528782, u'longitude': -122.411338984966}, u'state_code': u'CA'}
                  }]
}
</pre>
    </div>
</section>
### II. Demo in python - build my own function
See my code [here]()
<H4>4. Making use of the 3: "query _ api" </H4>
  <li>Give me any search parameters, I'll give you up to 20 businesses that meet these conditions.</li>
Call: query _ api('dinner', 'New York, NY')
Returned:
</section>
  <section>
#### II. Demo in python - use python package
Awesome guy's [github](https://github.com/gfairchild/yelpapi)
<li>One line to set up</li>
<li>One line to search by whatever terms you want</li>
Call: yelp _ api.search _ query(term='ice cream', location='austin, tx', sort=2, limit=5)
</section>
</section>



<section>
  <section>
#### III. Demo in R - visualization
<li>DATA</li>
  [Yelp Academic Dataset](https://www.yelp.com/academic_dataset)
  * business objects
  * review objects
  * user objects
<li>PACKAGES</li>
  * ggmap
  * rMaps
  * leaflet
</section>
  <section>
#### III. Demo in R - ggmap + ggplot
<H5>A Static Map</H5>
Manhattan Rating Map

![]()

</section>
 <section>
#### III. Demo in R - leaflet
<H5>A Dynamic Map</H5>
Manhattan Reviews Map
![](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/presentation/circle_reviews.html)
</section>
 <section>
#### III. Demo in R - rMaps
<H5>More Dynamic Maps</H5>
Chinese Places
</section>
 <section>
#### III. Demo in R - rMaps
<H5>More Dynamic Maps</H5>
Bars
</section>
 <section>
#### III. Demo in R - rMaps
<H5>More Dynamic Maps</H5>
Pizza
</section>
 <section>
#### III. Demo in R - rMaps
<H5>More Dynamic Maps</H5>
Morningside
</section>
</section>
