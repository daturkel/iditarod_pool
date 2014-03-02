require 'yaml' # enable the ability to parse YAML files

random_seed = 123123123
seeded_random = Random.new(random_seed)

mushers = [] # initialize the musher array
rookies = [] # initialize the rookie array

racer_file = YAML.load_file('racers.yaml') # load the YAML file of racers into a ruby hash
racer_file["mushers"].each do |i| # populate the mushers array from the hash
    mushers.push(i["name"])
end
racer_file["rookies"].each do |j| # populate the rookies array from the hash
    rookies.push(j["name"])
end

betters = [] # initialize the better array

better_file = YAML.load_file('betters.yaml') # load the YAML file of betters into a ruby hash
better_file["betters"].each do |k| # populate the betters array
    betters.push(k["name"])
end

mushers.shuffle!(random: seeded_random) # randomize the order of the musher, rookie, and better arrays
rookies.shuffle!(random: seeded_random)
betters.shuffle!(random: seeded_random)

results = {"random_seed" => random_seed, "listings" => []} # initalize the results hash which contains the random seed and a listings array which will contain hashes of each better and the mushers/rookies they get assigned
(0..betters.length-1).each do |l| # initialize the listings array with the betters' names and create arrays for their mushers and rookies
   results["listings"][l]={"name" => betters[l],"racers"=>{"mushers"=>[],"rookies"=>[]}}
end
mushers.each_with_index do |m,x| # give the betters each mushers
    a = x%betters.length
    results["listings"][a]["racers"]["mushers"].push(m)
end

rookies.each_with_index do |n,y| # give the betters each rookies
    e = y%betters.length
    results["listings"][betters.length-e-1]["racers"]["rookies"].push(n) # this step goes through the results array backwards so that people at the end of the results array are more likely to get an additional rookie, balancing out the fact that they may have gotten one fewer musher
end

File.open("output.yaml", "w+") { |file| file.write(results.to_yaml) } 

puts "random_seed = " + results["random_seed"].to_s
results["listings"].each do |z| # and, for good measure, pretty-print the results too
    puts z["name"] + " - " + (z["racers"]["mushers"].length+z["racers"]["rookies"].length).to_s + " racers"
    puts "   " + z["racers"]["mushers"].length.to_s + " mushers:"
    z["racers"]["mushers"].each do |alpha|
        puts "      " + alpha
    end
    puts "   " + z["racers"]["rookies"].length.to_s + " rookies:"
    z["racers"]["rookies"].each do |beta|
        puts "      " + beta
    end
end
