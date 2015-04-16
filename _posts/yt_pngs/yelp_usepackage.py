__author__ = 'yutian'

from yelpapi import YelpAPI

### setup yelp API connection using yelpapi
yelp_api = YelpAPI('your_consumer_key',
                   'your_consumer_secret',
                   'your_token',
                   'your_token_secret')


response = yelp_api.search_query(term='ice cream', location='austin, tx', sort=2, limit=5)
object = yelp_api.business_query(id='hopwater-distribution-san-francisco')
