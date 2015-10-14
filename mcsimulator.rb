require 'csv'
require_relative "mc_methods"
include McMethods

#Hashes of arrays of each item in each category. Key is a number, value is an array of an entire row in the csv
burgers = {}
chicken_or_fish = {}
breakfast = {}
salads = {}
sides = {}
beverages = {}
mccafe = {}
desserts_or_shakes = {}
condiments = {}

#categories hash will contain capitalized laymens keys for the column names in the csv
nutrient_type = {}

#counters will change and be assigned as keys which can be called as numbers i.e. "give me a number 1 => big mac"
burger_count = 1
chicken_count = 1
breakfast_count = 1
salad_count = 1
side_count = 1
beverage_count = 1
mccafe_count = 1
dessert_count = 1
condiment_count = 1

CSV.foreach('./menu.csv') do |row| #this path assumes the csv is in the same directory as this file. 
  case row[11] #11th item in each row litst the category of each item
  when "CATEGORY" #the first row contains the column titles
    nutrient_type["Item"] = row[0]
    nutrient_type["Calories"] = row[1]
    nutrient_type["Fat"] = row[2]
    nutrient_type["Saturated Fat"] = row[3]
    nutrient_type["Trans Fat"] = row[4]
    nutrient_type["Cholesterol"] = row[5]
    nutrient_type["Salt"] = row[6]
    nutrient_type["Carbohydrates"] = row[7]
    nutrient_type["Fiber"] = row[8]
    nutrient_type["Sugar"] = row[9]
    nutrient_type["Protein"] = row[10]
  when "BURGERSANDWICH"
    burgers[burger_count.to_s] = row
    burger_count += 1
  when "CHICKENFISH"
    chicken_or_fish[chicken_count.to_s] = row
    chicken_count += 1
  when "BREAKFAST"
    breakfast[breakfast_count.to_s] = row
    breakfast_count += 1
  when "SALAD"
    salads[salad_count.to_s] = row
    salad_count += 1
  when "SNACKSIDE"
    sides[side_count.to_s] = row
    side_count += 1
  when "BEVERAGE"
    beverages[beverage_count.to_s] = row
    beverage_count += 1
  when "MCCAFE"
    mccafe[mccafe_count.to_s] = row
    mccafe_count += 1
  when "DESSERTSHAKE"
    desserts_or_shakes[dessert_count.to_s] = row
    dessert_count += 1
  when "CONDIMENT"
    condiments[condiment_count.to_s] = row
    condiment_count += 1
  end
end

category = {"1" => burgers, "2" => chicken_or_fish, "3" => breakfast, "4" => salads, "5" => sides, "6" => beverages, "7" => mccafe, "8" => desserts_or_shakes, "9" => condiments}

#---------------------------Start Game--------------------------
choices = []
total_calories = 0
game_over = false
# goodbye = "Thank you, come again!" #obsolete
puts "\nWelcome to McDonald's, What will you have?"
puts "We have many different categories of items you can pick from:"
puts "\n\n\n\n\n\n\n\n\n\n\n"
puts first_prompt = "We have (1)BURGERS, (2)CHICKEN, (3)BREAKFAST, (4)SALADS, (5)SIDES, (6)DRINKS, (7)COFFEE, (8)DESSERTS and (9)CONDIMENTS or 'exit'"


# ------------------------------------------------------------- Start of loop 1 --------------------------------------------------
until game_over == true do #first section selection
  user_choice1 = gets.chomp.downcase
  if user_choice1 == "exit" #exiting the program
    puts "\n\n\n"

    game_over = goodbye
  elsif (category.keys.include? user_choice1) == false #checks for erroneous input
    puts "\n\n\n"
    puts "We don't have that type of item in our menu, this ain't Burger King, you can't have it your way!"
  else
    item_list(user_choice1, category)
    skip_loop_2 = false
# ------------------------------------------------------------- Start of loop 2 --------------------------------------------------
    until skip_loop_2 == true #loop2 = after choosing category of food, this is where the user chooses an item in that category
      user_choice2 = gets.chomp.downcase

      if user_choice2 == "categories"
        puts "\n\n\n"
        puts first_prompt
        break #travels up to first loop to ask initial question
      elsif user_choice2 == "exit"
        game_over = goodbye
        puts "\n\n\n"
        break
      elsif !(category[user_choice1].keys.include? user_choice2)
        # This also works. CELESTE! #(((1..category[user_choice1].length).to_a.join(" ").split(" ")).include? user_choice2) == false
        puts "You have not selected an item on the list.\nPlease select an item by it's number.\nYou can also go back to 'categories' or 'exit'"
        redo
      else
        puts "\n\n\n"
        puts "You selected: #{category[user_choice1][user_choice2][0]} which contains:"
        10.times do |i|
          i+=1
          puts "#{nutrient_type.keys[i]}: #{category[user_choice1][user_choice2][i]}"
        end
        puts "\n\n\n"
        puts "Will that complete your order? You can 'add' more to your order, 'remove' this item, 'check' out or 'exit'?"
        choices << category[user_choice1][user_choice2]
        skip_loop_3 = false
# ------------------------------------------------------------- Start of loop 3 --------------------------------------------------
        until skip_loop_3 == true #loop3 = after choosing an item, this is where the user chooses whether to keep shopping, look at cart, remove last item, or quit.
          user_choice3 = gets.chomp.downcase
          if user_choice3 == "add"
            skip_loop_2 = true #ensures user goes back to first loop
            puts "\n\n\n"
            puts first_prompt
            break #will send user to loop2
          elsif user_choice3 == "remove"
            if choices.length == 0
              puts "\n\n\n"
              puts "There is nothing in your list of selections to remove"
            else
              c = choices.pop
              puts "\n\n\n"
              puts "The item #{c[0]} has been removed"
              puts "Will that complete your order? You can 'add' more to your order, 'remove' an item, 'check' out or 'exit'?"
            end
          elsif user_choice3 == "check"
            if choices.length == 0
              puts "\n\n\n"
              puts "There are no tasty McFoods in your selection list, you can 'add' some or 'exit'"
            else
              puts "\n\n\n"
              puts "So far I have you down for:"
              non_unique = choices.select{ |e| choices.count(e) > 1}.uniq
              non_unique.each do |i| #displays duplicate items and their count
                puts "#{choices.count(i)} x #{i[0]}"
              end
              unique = choices.uniq - non_unique
              unique.each do |i| #displays uniqe items
                puts "1 x #{i[0]}"
              end
              puts "\n\n\n"
              puts "Is this your final selection? You can go 'back' to change your selections or 'finalize' your meal or 'exit'"
              # skip_loop_2 = true #ensures user goes back to first loop
              # break #will send user to loop2
# ------------------------------------------------------------- Start of loop 4 --------------------------------------------------
              output = output_total_nutritional_content(choices, nutrient_type, total_calories)
              game_over = output
              skip_loop_2 = output
              skip_loop_3 = output
# ------------------------------------------------------------- End of loop 4 --------------------------------------------------
            end
          elsif user_choice3 == 'exit'

            game_over = goodbye
            skip_loop_2 = true
            break
          else
            puts "Sorry I did not understand you, can you repeat that please? You can 'add' more to your order, 'remove' this item, 'check' out or 'exit'"
            redo
          end
        end
# ------------------------------------------------------------- End of loop 3 --------------------------------------------------
      end
    end
  end
end
