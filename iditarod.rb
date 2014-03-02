require 'yaml' # enable the ability to parse YAML files

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

mushers.shuffle! # randomize the order of the musher, rookie, and better arrays
rookies.shuffle!
betters.shuffle!

property = [] # initialize the property array, it will be an array of hashes which each represent a better and the mushers and rookies they "own"
(0..betters.length-1).each do |l| # initialize the property array with the betters' names and create arrays for their mushers and rookies
   property[l]={"name" => betters[l],"racers"=>{"mushers"=>[],"rookies"=>[]}}
end
mushers.each_with_index do |m,x| # give the betters each mushers
    a = x%betters.length
    property[a]["racers"]["mushers"].push(m)
end

rookies.each_with_index do |n,y| # give the betters each rookies
    e = y%betters.length
    property[betters.length-e-1]["racers"]["rookies"].push(n) # this step goes through the property array backwards so that people at the end of the property array are more likely to get an additional rookie, balancing out the fact that they may have gotten one fewer musher
end

File.open("output.yaml", "w") { |file| file.write(property.to_yaml)} # output the results to a file

property.each do |z| # and, for good measure, pretty-print the results too
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
