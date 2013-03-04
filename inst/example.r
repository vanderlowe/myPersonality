localConfig()

p <- getData(participants("age > 65", "gender = 1", "network_size"))
a <- getData(address("current_location_city = 'New York'"))

p[a, nomatch = 0]

explain("address")
variables("address")