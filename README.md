# Dan's Iditarod Betting Pool!

## Welcome

Welcome to the Github repo for Dan's Iditarod Betting Pool! In the interest of full disclosure, and since there's some *serious cash* on the line here, I figured I'd make the musher assignment process totally transparent for this betting pool. In this repo, you'll find a Ruby script `iditarod.rb` which is the exact script used to assign mushers to betters. The list of mushers, subdivided into regular mushers and rookie mushers (who have not raced before), is included as well in the form of `racers.yaml`. The `betters.yaml` file and a sample `output.yaml` file have been replaced with dummy versions to protect the privacy of those whose last names are in the real files.

## Rationale

My friends and I had an Iditarod betting pool in high school, but we did it draft pick style. The draft pick order was random, but the person who got first pick got to pick [Lance Mackey](http://en.wikipedia.org/wiki/Lance_Mackey), winner of the 2007-2010 Iditarod races, and it was totally unfair and lame (although he didn't end up winning!). I decided that in the future, the fairest way to distribute mushers would be to randomly assign them.

The `iditarod.rb` script randomly divvies up the non-rookie mushers to the betters, and then divvies the rookies in reverse order so that betters towards the end of the list, who may have received one fewer musher than the betters at the beginning of the list, will get rookies first and thus possibly balance out the distribution. This should prevent any one better from having more than one musher than the person with the least number of mushers assigned.

## Auditing

It would be pretty easy for me to fake the output and stack the odds however I wanted! That's why I've included the ability for you to audit results if you're so inclined. Line 3 of `iditarod.rb` contains a declaration of the variable `random_seed` which is used to seed the random-number-generator which is then used to shuffle the musher array, rookie array, and better array before the mushers get divvied. When the script is run multiple times for the same random seed, the results are always the same.

On the day of the divvying, we'll randomly choose a seed and I'll update the file here. I will post the real `betters.yaml` file to the Facebook group and you can run the script yourself to ensure that your results match mine. Running the script is simple. Download the `iditarod.rb` file, the `racers.yaml` file, and the `betters.yaml` file (the last one coming from the Facebook group). Ensure that the random seed in `iditarod.rb` is set to the final proper value. Then `cd` to the directory with these files in it in your terminal of choice and run `ruby iditarod.rb`. Then simply open the `output.yaml` file that gets created and compare it to the one I'll publish. You'll find that it's exactly the same.

## Fin.

The pool's over and everything worked great!
