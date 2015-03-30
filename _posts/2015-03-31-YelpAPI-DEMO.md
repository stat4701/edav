---
layout: post
title: Yelp API - DEMO
author: Yu Tian
date: "March 31, 2015"
description: pair presentaion
tags: R, python, Yelp API, ggmap, rMaps, Leaflet, ggplot, presentation
---

Returned:
<section>
<code>{ 
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
</code>
</section>



<section>
## I. Demo in python - get data

Feel free to use [Yelp Academic Dataset](https://www.yelp.com/academic_dataset)
<section>
### a. build my own functions

See my code [here]()

1. The very fundamental componet: "request"
 * Send your request to yelp by passing a url that points to the object.

2. Feature A: "get _ business" </H4>
 * Tell me the business id, I'll give you the information I allow you to see.

Call: get _ business('upstate-new-york-2')

Returned:
<section>
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

3. Feature B: "search" 

<li>Highly customizable</li>
<li>Give me any of <a href="https://www.yelp.com/developers/documentation/v2/search_api">these</a> search parameters, I'll give you a summary information about businesses in this region.</li>

Call: search('bar','San Francisco, CA')

Returned:
<ul>
<section>
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
</ul>

4. Making use of the 3: "query _ api"

  * Give me any search parameters, I'll give you up to 20 businesses that meet these conditions.

Call: query _ api('dinner', 'New York, NY')

Returned: 3 businesses found meet the conditions.
<ul>
<section>
<div class="island code-sample">
        <pre>
Querying http://api.yelp.com/v2/search/? ...
{u'region': {u'span': {u'latitude_delta': 0.0, u'longitude_delta': 0.0}, 
             u'center': {u'latitude': 40.7263139141197, u'longitude': -73.9864901976935}}, 
             u'total': 19403, 
             u'businesses': [{u'is_claimed': True, 
                              u'rating': 4.5, 
                              u'mobile_url': u'http://m.yelp.com/biz/upstate-new-york-2', 
                              u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', 
                              u'review_count': 873, 
                              u'name': u'Upstate', 
                              u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', 
                              u'url': u'http://www.yelp.com/biz/upstate-new-york-2', 
                              u'is_closed': False, 
                              u'id': u'upstate-new-york-2', 
                              u'phone': u'9174083395', 
                              u'snippet_text': u"I never give 5 stars. I always think it will look more authentic if I put four. I can't not give this place five stars. It was the most incredible...", u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/RuzizPitO3wvIUJRyhZ5MA/ms.jpg', 
                              u'categories': [[u'American (New)', u'newamerican'], [u'Seafood', u'seafood']], 
                              u'display_phone': u'+1-917-408-3395', 
                              u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png',
                              u'menu_provider': u'single_platform', 
                              u'menu_date_updated': 1416597147, 
                              u'snippet_image_url': u'http://s3-media4.fl.yelpassets.com/photo/dlu2wYiYysLbt5sdjiXbbA/ms.jpg', 
                              u'location': {u'city': u'New York', 
                                            u'display_address': [u'95 1st Ave', u'East Village', u'New York, NY 10003'], 
                                            u'geo_accuracy': 9.5, 
                                            u'neighborhoods': [u'East Village'], 
                                            u'postal_code': u'10003', 
                                            u'country_code': u'US', 
                                            u'address': [u'95 1st Ave'], 
                                            u'coordinate': {u'latitude': 40.7263139141197, u'longitude': -73.9864901976935}, 
                                            u'state_code': u'NY'}
                              }]
}


Result for business "upstate-new-york-2" found:
{ u'categories': [ [u'American (New)', u'newamerican'],
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
  u'review_count': 873,
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
</section>
</ul>
<section>
### b. use python package

Awesome guy's [github](https://github.com/gfairchild/yelpapi)

* One line to set up

* One line to search by whatever terms you want

Call: yelp _ api.search _ query(term='ice cream', location='austin, tx', sort=2, limit=5)

Returned:
<ul>
<section>
<div>
  <pre>
    {u'region': {u'span': {u'latitude_delta': 0.2485112299999983, u'longitude_delta': 0.06858553581440674}, u'center': {u'latitude': 30.32842615, u'longitude': -97.766491156448}}, u'total': 40, u'businesses': [{u'is_claimed': True, u'rating': 5.0, u'mobile_url': u'http://m.yelp.com/biz/dolce-neve-austin', u'rating_img_url': u'http://s3-media1.fl.yelpassets.com/assets/2/www/img/f1def11e4e79/ico/stars/v1/stars_5.png', u'review_count': 217, u'name': u'Dolce Neve', u'rating_img_url_small': u'http://s3-media1.fl.yelpassets.com/assets/2/www/img/c7623205d5cd/ico/stars/v1/stars_small_5.png', u'url': u'http://www.yelp.com/biz/dolce-neve-austin', u'is_closed': False, u'phone': u'5128045568', u'snippet_text': u"I'm really not into ice cream. That's because normally the ingredients are of doubtful origin. But I have to admit that this place has great flavor,...", u'image_url': u'http://s3-media2.fl.yelpassets.com/bphoto/0AZaE-8bepfjMCU54rGltQ/ms.jpg', u'categories': [[u'Gelato', u'gelato'], [u'Ice Cream & Frozen Yogurt', u'icecream'], [u'Coffee & Tea', u'coffee']], u'display_phone': u'+1-512-804-5568', u'rating_img_url_large': u'http://s3-media3.fl.yelpassets.com/assets/2/www/img/22affc4e6c38/ico/stars/v1/stars_large_5.png', u'id': u'dolce-neve-austin', u'snippet_image_url': u'http://s3-media1.fl.yelpassets.com/photo/pyiDqz1juWR1nJHGAeOMQw/ms.jpg', u'location': {u'city': u'Austin', u'display_address': [u'1713 S 1st St', u'So-Fi (S. 1st St. District)', u'Austin, TX 78704'], u'geo_accuracy': 9.5, u'neighborhoods': [u'So-Fi (S. 1st St. District)', u'78704 (South Austin)', u'Bouldin Creek'], u'postal_code': u'78704', u'country_code': u'US', u'address': [u'1713 S 1st St'], u'coordinate': {u'latitude': 30.247625, u'longitude': -97.755404}, u'state_code': u'TX'}}, {u'is_claimed': False, u'rating': 4.5, u'mobile_url': u'http://m.yelp.com/biz/frozen-rickshaw-austin', u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', u'review_count': 51, u'name': u'Frozen Rickshaw', u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', u'url': u'http://www.yelp.com/biz/frozen-rickshaw-austin', u'is_closed': False, u'phone': u'5126779986', u'snippet_text': u"Favorite, favorite place to get mochi ice cream in Austin. I've come here a lot and the owner is super chill and friendly. She comes up with all of the...", u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/nAJJJ7UXlXuRzptRGB4wuw/ms.jpg', u'categories': [[u'Food Trucks', u'foodtrucks'], [u'Ice Cream & Frozen Yogurt', u'icecream']], u'display_phone': u'+1-512-677-9986', u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', u'id': u'frozen-rickshaw-austin', u'snippet_image_url': u'http://s3-media1.fl.yelpassets.com/photo/JIr4h5qteUX5sqPN3dBCKQ/ms.jpg', u'location': {u'city': u'Austin', u'display_address': [u'502 W 30th St', u'University of Texas', u'Austin, TX 78705'], u'geo_accuracy': 8.0, u'neighborhoods': [u'University of Texas'], u'postal_code': u'78705', u'country_code': u'US', u'address': [u'502 W 30th St'], u'coordinate': {u'latitude': 30.2963409, u'longitude': -97.7413864}, u'state_code': u'TX'}}, {u'is_claimed': True, u'rating': 4.5, u'mobile_url': u'http://m.yelp.com/biz/ritas-italian-ice-austin-2', u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', u'review_count': 38, u'name': u"Rita's Italian Ice", u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', u'url': u'http://www.yelp.com/biz/ritas-italian-ice-austin-2', u'is_closed': False, u'phone': u'5129968436', u'snippet_text': u"I go here way more times than I'm comfortable sharing on social media of any kind. I love Rita's so very much! It is refreshing and sweet, not icy or...", u'image_url': u'http://s3-media2.fl.yelpassets.com/bphoto/42lHh1HHHSAGAUUly-i1iw/ms.jpg', u'categories': [[u'Ice Cream & Frozen Yogurt', u'icecream'], [u'Desserts', u'desserts'], [u'Shaved Ice', u'shavedice']], u'display_phone': u'+1-512-996-8436', u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', u'id': u'ritas-italian-ice-austin-2', u'snippet_image_url': u'http://s3-media4.fl.yelpassets.com/photo/SnMCHnbwMShE4J_9eSYQgg/ms.jpg', u'location': {u'city': u'Austin', u'display_address': [u'McNeil Crossing Shopping Center', u'6001 W. Parmer Lane', u'Austin, TX 78727'], u'geo_accuracy': 8.0, u'postal_code': u'78727', u'country_code': u'US', u'address': [u'McNeil Crossing Shopping Center', u'6001 W. Parmer Lane'], u'coordinate': {u'latitude': 30.4414501, u'longitude': -97.7425308}, u'state_code': u'TX'}}, {u'is_claimed': False, u'rating': 4.5, u'mobile_url': u'http://m.yelp.com/biz/south-austin-sno-austin', u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', u'review_count': 24, u'name': u'South Austin Sno', u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', u'url': u'http://www.yelp.com/biz/south-austin-sno-austin', u'is_closed': False, u'snippet_text': u'The smoothest shaved ice in town; there is no comparison. So many flavors to choose from and each one is delicious. Customer service is great.  They always...', u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/S8zCXmIpZNuSxzP19UAfaQ/ms.jpg', u'categories': [[u'Ice Cream & Frozen Yogurt', u'icecream'], [u'Food Stands', u'foodstands']], u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', u'id': u'south-austin-sno-austin', u'snippet_image_url': u'http://s3-media2.fl.yelpassets.com/photo/lzmgwVOIN9hLLZJe265acQ/ms.jpg', u'location': {u'city': u'Austin', u'display_address': [u'Manchaca & Stassney', u'Austin, TX 78704'], u'geo_accuracy': 7.0, u'postal_code': u'78704', u'country_code': u'US', u'address': [u'Manchaca & Stassney'], u'coordinate': {u'latitude': 30.2154408, u'longitude': -97.7976074}, u'state_code': u'TX'}}, {u'is_claimed': False, u'rating': 4.5, u'mobile_url': u'http://m.yelp.com/biz/yogurtland-austin', u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', u'review_count': 111, u'name': u'Yogurtland', u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', u'url': u'http://www.yelp.com/biz/yogurtland-austin', u'is_closed': False, u'phone': u'5124527300', u'snippet_text': u'The best frozen yogurt. Great flavors with an endless supply of toppings. Thankful for the request to join the reward club. This way you get a few extra...', u'image_url': u'http://s3-media4.fl.yelpassets.com/bphoto/Sr9c34lwC71mOU2E7Pv2Cg/ms.jpg', u'categories': [[u'Ice Cream & Frozen Yogurt', u'icecream']], u'display_phone': u'+1-512-452-7300', u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', u'id': u'yogurtland-austin', u'snippet_image_url': u'http://s3-media1.fl.yelpassets.com/photo/kOTfdvzQBcTaWgYBmOyOeg/ms.jpg', u'location': {u'city': u'Austin', u'display_address': [u'2525 W Anderson Ln', u'Bldg 1, Ste 125', u'Allandale', u'Austin, TX 78757'], u'geo_accuracy': 9.5, u'neighborhoods': [u'Allandale'], u'postal_code': u'78757', u'country_code': u'US', u'address': [u'2525 W Anderson Ln', u'Bldg 1, Ste 125'], u'coordinate': {u'latitude': 30.356771946275, u'longitude': -97.735315912896}, u'state_code': u'TX'}}]}
Querying http://api.yelp.com/v2/search/? ...
{u'region': {u'span': {u'latitude_delta': 0.0, u'longitude_delta': 0.0}, u'center': {u'latitude': 40.7263139141197, u'longitude': -73.9864901976935}}, u'total': 19403, u'businesses': [{u'is_claimed': True, u'rating': 4.5, u'mobile_url': u'http://m.yelp.com/biz/upstate-new-york-2', u'rating_img_url': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/99493c12711e/ico/stars/v1/stars_4_half.png', u'review_count': 873, u'name': u'Upstate', u'rating_img_url_small': u'http://s3-media2.fl.yelpassets.com/assets/2/www/img/a5221e66bc70/ico/stars/v1/stars_small_4_half.png', u'url': u'http://www.yelp.com/biz/upstate-new-york-2', u'is_closed': False, u'id': u'upstate-new-york-2', u'phone': u'9174083395', u'snippet_text': u"I never give 5 stars. I always think it will look more authentic if I put four. I can't not give this place five stars. It was the most incredible...", u'image_url': u'http://s3-media1.fl.yelpassets.com/bphoto/RuzizPitO3wvIUJRyhZ5MA/ms.jpg', u'categories': [[u'American (New)', u'newamerican'], [u'Seafood', u'seafood']], u'display_phone': u'+1-917-408-3395', u'rating_img_url_large': u'http://s3-media4.fl.yelpassets.com/assets/2/www/img/9f83790ff7f6/ico/stars/v1/stars_large_4_half.png', u'menu_provider': u'single_platform', u'menu_date_updated': 1416597147, u'snippet_image_url': u'http://s3-media4.fl.yelpassets.com/photo/dlu2wYiYysLbt5sdjiXbbA/ms.jpg', u'location': {u'city': u'New York', u'display_address': [u'95 1st Ave', u'East Village', u'New York, NY 10003'], u'geo_accuracy': 9.5, u'neighborhoods': [u'East Village'], u'postal_code': u'10003', u'country_code': u'US', u'address': [u'95 1st Ave'], u'coordinate': {u'latitude': 40.7263139141197, u'longitude': -73.9864901976935}, u'state_code': u'NY'}}]}
1 businesses found, querying business info for the top result "upstate-new-york-2" ...
Querying http://api.yelp.com/v2/business/upstate-new-york-2? ...
Result for business "upstate-new-york-2" found:
{ u'categories': [ [u'American (New)', u'newamerican'],
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
  u'review_count': 873,
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
</section>
</ul>
<section>
## II. Demo in R - visualization

  * ggmap
  * rMaps
  * leaflet



### a. ggmap + ggplot

A Static Map

 * Manhattan Rating Map

![](https://raw.githubusercontent.com/YuTian9/edav/gh-pages/_posts/yt_pngs/manhattan_rating_map.png)


### b. leaflet

A Dynamic Map

 * Manhattan Reviews Map

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/circle_reviews.html)

### c. rMaps

More Dynamic Maps

  * Chinese Places

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/chinese.html)

file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/chinese.html

  * Bars

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/bar.html)


  * Pizza

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/pizza.html)

  * Morningside

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/morningside.html)

  * Upper West

[see](file:///Users/yutian/Documents/QMSS/2015spring/DataViz/3presentation/upper_west.html)


</section>
