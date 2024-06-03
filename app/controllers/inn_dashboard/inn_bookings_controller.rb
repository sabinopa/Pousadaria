class InnDashboard::InnBookingsController < InnDashboard::InnDashboardController
  def index
    @inn_booking = @inn.inn_bookings
  end

  def show
    @inn_booking = @inn.inn_bookings.find_by(params[:id])
  end

  def new
    @inn_booking = @inn.inn_bookings.build
  end

  def create
    @inn_booking = @inn.inn_bookings.build(booking_params)
    if @inn_booking.save
      return redirect_to inn_management_path, notice: 'Reserva salva com sucesso'
    end
    render :new, status: :unprocessable_entity
  end

  def add_room
    # criar model room_on_booking de mts pra mts
    #vai ser algo como:: @inn_booking.inn << @inn_rooms
  end

  private

  def booking_params
    params.require(:inn_booking).permit(:name, :start_date, :end_date)
  end
end