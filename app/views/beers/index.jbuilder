json.array! @beers do |beer|

  json.id beer.id
  json.name beer.name
  json.price beer.price
  json.description beer.description
  json.pair_with beer.pair_with

end