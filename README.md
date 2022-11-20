To run tests `rspec spec`
# My Thoughts

## Setup

> Initial set up `bundle install`
>
> To run input `ruby brilliant_run_code.rb input.txt`
>
> For tests `rspec spec`

First thing we need to look at when viewing this problem is the data you're receiving and their associations. In my mind these three commands would be models, we have our register which creates our items we want to sell and the price, checkin will create the amount of registered items you have, then order will create the connection between the product and a user. 

Since we really don't have a way to store anything since we don't have a database, I chose to create class methods that mimic queries with ActiveRecord. This will include:

* An all query that will give us all the instances created (.all). This will also be stored as a variable to use within the class (@@all).
* A find query, which will give us the first instance that matches a passed parameter (.find)

When it comes to ordering, if we don't have a correct order we don't want to go through the whole process as a correct order, so we cut out that part by using a check for amounts in the `order.rb` file (`if Checkin.find(item).amount >= amount.to_f`). If the amounts work then we will run the whole order creation.

Now that I have most of the parts working I want to revisit the below loop to make it more dynamic. I know in Rails we have the ability to use `.constantize` in order to turn strings into constants and help us run the according class files. To do it here you'd use `Object.const_get((split_line[0]).capitalize)` this will take the string (which also needs to be capitalized) and find the coordinating class. Another good reason to do this is if it fails we can catch that error in the rescue and it should help the next developer realize we need to add a class file.

### Old way
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

### New way
>      File.foreach(ARGV[0]) do |line|
>        split_line = line.split(" ")
>        if split_line.count == 3
>          Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2])
>        else
>          Object.const_get((split_line.first).capitalize).new(split_line[1], split_line[2], split_line[3])
>        end
>      end