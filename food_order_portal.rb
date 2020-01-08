class FoodOrder
	attr_accessor :requested_quantity ,:delievery_status , :food_choice , :cost_per_item
  # menu - array of hash (stores food details)
  # key :- food item name
  # value :- array[ avaialable_quantity , cost_per_item]

  @@menu = [{"Pizza":[10,100]},{"Burger":[9,100]},{"Dosa":[0,200]},{"Idli":[3,500]}]

  def initialize()
		@requested_quantity = 0
    @delievery_status = false
    @food_choice = 0
    @cost_per_item = 0
	end

  def self.display_menu
    i=0
    puts "\n\t\t---- Welcome to Foodies Restraurant ----"
    puts "\n\t\t\t----- Menu ----\n\n"
    @@menu.each do |item|
      i+=1
      s = item.keys[0].to_s
      puts "\t\t\t   #{i}. #{s}"
  	end
  end

  def place_order
    customer_food_choice()
    if available()
      accept_order()
    else
      puts "\tSorry , Item not avaialble"
      #if item currently not available , call place_order function one more time
      place_order()
    end
  end

  def customer_food_choice
    print "\n\tEnter food choice (1/2/3/4) :"
    @food_choice = (gets.to_i)-1
    if @food_choice > 3 or @food_choice < 0
      puts "\n\t\tWrong choice ..."
      customer_food_choice()
    end
    print "\n\tEnter Quantity (1-10) : "
    @requested_quantity = gets.to_i

  end
  
  #check availability of food items depending on their quantity left
  def available()
    details = get_food_details()
    available_quantity = details[0]
    @cost_per_item = details[1]
    if @requested_quantity <= available_quantity
      return true
    else 
      return false
    end
  end

  # below function returns available quantity and cost per item
  def get_food_details
    h = @@menu[@food_choice]
    i = h.keys
    item = i[0]
    #return details in array form
    return h[item]
  end

  # calculates total cost
  def total_cost
    return @requested_quantity * @cost_per_item
  end

  # returns true if order placed , false if failure 
	def accept_order()
    puts "\t\tItem available , Preparing Your Order..."
    cost = total_cost()
    puts "\t\tCost : Rs.#{cost}\n"
    # ask user food has delievered or not
    print "\tFood Deleivered or not (1/0) ? -> "
    status = gets.to_i
    if status == 1
      @delievery_status = true
      puts "\n\n\t\tYour order is successful...Thank You !\n\n"
      return @delievery_status
    else
      @delievery_status = false
      puts "\t\tOrder Failed Please try again...\n"
      place_order()
      return false
    end
	end


end

o = FoodOrder.new()
FoodOrder.display_menu
o.place_order()


