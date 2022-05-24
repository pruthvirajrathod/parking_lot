class ParkingLot
  attr_reader :tickets
  def initialize(size)
    @tickets = Array.new(size)
  end

  def available_ticket
    tickets.each_with_index do |ticket, i|
      return i if ticket.nil?
    end
    nil
  end

  def park(car:, ticket_num:)
    tickets[ticket_num] = car
  end

  def leave(ticket_num)
    tickets[ticket_num] = nil
  end

  def get_reg_by_color(color)
    result = []
    tickets.each do |ticket|
      next unless ticket
      result << ticket[0][:reg_no] if ticket[0][:color] == color
    end
    result
  end

  def get_ticket_with_color(color)
    result = []
    tickets.each_with_index do |ticket, i|
      next unless ticket
      result << (i + 1).to_s if ticket[0][:color] == color
    end
    result
  end
 
  def get_ticket_with_reg_no(reg_no)
    tickets.each_with_index do |ticket, i|
      next unless ticket
      return (i + 1).to_s if ticket[0][:reg_no] == reg_no
    end
    nil
  end
end