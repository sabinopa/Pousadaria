class InnDashboard::InnBookingsController < InnDashboard::InnDashboardController

  def new
    @inn_booking = @inn.inn_bookings.build
  end

  def create

  end

  def add_room
    #vai ser algo como:: @inn_booking.inn << @inn_rooms
  end
end