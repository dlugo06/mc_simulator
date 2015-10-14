module McMethods
  def goodbye
    puts "Thank you, come again!"
    return true
  end

#This method is meant to display all of the items in the category chosen by the user and represented by user_choice1.
  def item_list(choice, category_reference)
    length_of_item_list = category_reference[choice].length
    puts "\n\n\n"
    puts "You have #{length_of_item_list} options below, which would you like? You can also type 'categories' to select another category"
    puts "\n"
    (length_of_item_list).times do |i|
      i += 1
      puts "#{i}: #{category_reference[choice][i.to_s][0]}"
    end
    puts "\n"
    puts "You have #{length_of_item_list} options above, which would you like? You can also type 'categories' to select another category"
  end

  #This method means to output the nutritional content of all of the items chosen.
  def output_total_nutritional_content(choices, nutrient_type, total_calories)
  loop do #loop 4 = after seeing cart. This is where the user chooses to finalize transaction, go back
        user_choice4 = gets.chomp.downcase
        if user_choice4 == "back"
          puts "\n\n\n"
          puts "More food? Very well then, what would you like to 'add'? You can also 'remove' the last item, 'check' out or 'exit'"
          return false
        elsif user_choice4 == "finalize"
          puts "\n\n\n"
          puts "Your total will be:"
          10.times do |j| #nutrient type
            j+=1
            total_nutrient_content = 0
            choices.each do |i|
              total_nutrient_content += i[j].to_f
            end
            puts  "#{nutrient_type.keys[j]}: #{total_nutrient_content}"
            if nutrient_type.keys[j] == "Calories"
              total_calories = total_nutrient_content
            end
          end
          miles = total_calories/100
          puts "\nTo burn this off, you would have to run about #{miles} miles"
          puts "\n\n\n"
          puts "Please pull up to the window to receive your food."
          return true
        elsif user_choice4 == "exit"
          puts "\n\n\n"
          return true
        else
          puts "\n\n\n"
          puts "There are other customers waiting... You can go 'back', 'finalize' or 'exit'"
          # redo
        end
      end
  end
end
