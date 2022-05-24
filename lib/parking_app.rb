class ParkingApp
	attr_reader :input_path, :parking_lot, :cmd

  	def initialize
	    @cmd = {
    		new_lot: method(:new_lot),
		    leave: method(:leave_scheduled),
		    all_cars_with_reg_no_using_color: method(:find_reg_no_by_color),
		    ticket_for_cars_with_color: method(:ticket_numbers_by_color),
		    ticket_for_reg_no: method(:ticket_for_reg_no)
    	}
  	end

  	def start_app
    	input_filename = ARGV[0]

	    if input_filename
    	  	set_path input_filename
      		read_file
    	else
      	end
 	end

  	def read_file
    	file = File.open(input_path, 'r')

	    file.each_line do |f|
    		parse_file f
    	end
  	end

  	def parse_file(i)
    	method_call = i.split
    	if method_call.size == 1
      		show_data parking_lot.tickets
    	elsif method_call.size == 2
    		fetch_data method_call
    	elsif method_call.size == 3
    		check_ticket method_call
    	end
  	end

  	def new_lot(size)
    	# size_in_int = printer.str_to_int size_in_str
    	@parking_lot = ParkingLot.new(size.to_i)
	    puts 'New ParkingLot ready with ' + size + ' tickets'
  	end

  	def fetch_data(method_call)
    	cmd[method_call[0].to_sym].call method_call[1]
  	end

  	def leave_scheduled(ticket)
    	remove_ticket(ticket.to_i - 1)
    	puts "\nTicket no. " + ticket + ' is available now for use.'
  	end

  	def remove_ticket(ticket_num)
  		parking_lot.leave ticket_num
  	end

  	def park_in_ticket(reg_no:, color:, ticket_num:)
	    car = Car.new
	    parking_lot.park(car: [reg_no: reg_no, color: color], ticket_num: ticket_num)
	end

	def execute_parking(reg_no:, color:, ticket_num:)
	    park_in_ticket(reg_no: reg_no, color: color, ticket_num: ticket_num)
	    puts 'You have parked on Ticket No: ' + (ticket_num + 1).to_s
	end

	def check_ticket(method_call)
	    ticket_num = parking_lot.available_ticket

	    if ticket_num
	      execute_parking(reg_no: method_call[1], color: method_call[2], ticket_num: ticket_num)
	    else
	      puts "\nSorry, parking lot dont have more space."
	    end
 	end

  	def find_reg_no_by_color(color)
    	results = parking_lot.get_reg_by_color(color)
    	puts "\nRegistered number's with #{color} color are: "+results.join(", ")
  	end

  	def ticket_numbers_by_color(color)
    	results = parking_lot.get_ticket_with_color(color)
   		puts "\nTicket number with #{color} color are: "+results.join(", ")
  	end

  	def ticket_for_reg_no(reg_no)
    	ticket_num = parking_lot.get_ticket_with_reg_no(reg_no)
    	puts "\nNo Ticket found for Reg no.: #{reg_no}"  unless ticket_num
    	puts "\nTicket number for Reg No. #{reg_no} is: "+ ticket_num.to_s 
    end

  	def show_data(tickets)
	    header = "\n\nTicket No.	Reg No			Color\n\n"
	    tickets.each_with_index do |ticket, i|
	    next unless ticket
	      header += (i + 1).to_s + '		' + ticket[0][:reg_no] + '		' + ticket[0][:color]
	      header += "\n"
	    end
	    puts header + "\n\n\n"
	end


  	private

	def set_path(f_name)
    	@input_path = f_name
  	end
end