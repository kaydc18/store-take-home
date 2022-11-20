To run tests `rspec spec`
# My Thoughts

## Setup

> Initial set up `bundle install`
> To run input `ruby brilliant_run_code.rb input.txt`
> For tests `rspec spec`

First thing we need to look at when viewing this problem is the data you're receiving and their associations. In my mind these three commands would be models in a database, we have our register which creates our items we want to sell and the price, checkin will create the amount of registered items you have, then order will create the connection between the product and a user. 

Since we really don't have a way to store anything since we don't have a database, I chose to create class variables that mimic an all query with ActiveRecord. This way we can get a list of all the instances of each class for later. Considering we will need to sift through and remove amounts per order and match it with a price, this was my way of mimicing a database.

When it comes to ordering, if we don't have a correct order we don't want to go through the whole process as a correct order, so we cut out that part by using a check for amounts. If the amounts work then we will run the whole order creation.

Another thing I want to have is a method for finding specific instances, these should also be contained in each class much like a query in model.

Now that I have most of the parts working I want to revisit this loop. It can definitely be a lot more dynamic. I know in Rails we have the ability to use constantize in order to turn strings into constants and help us run the according class files. To do it here you'd use `Object.const_get((split_line[0]).capitalize)` this will take the string (which also needs to be capitalized) and find the coordinating class. Another good reason to do this is if it fails we can catch that error in the rescue and it should help the next developer realize we need to add a class file.

> Old way
>
>       File.foreach(ARGV[0]) do |line|
>         split_line = line.split(" ")
>         if split_line[0] == "register"
>           Register.new(split_line[1], split_line[2])
>         elsif split_line[0] == "checkin"
>           Checkin.new(split_line[1], split_line[2])
>         elsif split_line[0] == "order"
>           Order.new(split_line[1], split_line[2], split_line[3])
>         end
>       end

## For Testing

I tried my best to cover all the methods I created per class, and the instance variables. I also tried to add some error handling to the page that runs the files in order to catch any errors a future developer would need. There is at least one spot that should be improved, I didn't cover duplicates being delivered to the class methods. I actually figured this out as I was adding my method tests.