require 'rails_helper'

describe 'Inn Owner sees bookings' do
  it 'from home page' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar',
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    first_booking = inn.inn_bookings.create!(name: 'Encontro Idosos', start_date: 10.days.from_now, end_date: 12.days.from_now)

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Ver Reservas'

    expect(current_path).to inn_dashboard_inns_inn_bookings_path

  end
end