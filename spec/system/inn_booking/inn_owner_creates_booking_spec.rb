require 'rails_helper'

describe 'Inn Owner creates booking' do
  it 'from home page' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar',
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousadas'
    click_on 'Criar Reserva'

    expect(current_path).to eq new_inn_dashboard_inns_inn_bookings_path
  end

  it 'and sees complete form' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar',
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit new_inn_dashboard_inns_inn_bookings_path(inn_owner.id)

    expect(page).to have_content 'Criar nova reserva'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Data Início'
    expect(page).to have_field 'Data Final'
    expect(page).to have_button 'Salvar'
  end

  it 'with incomplete data' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar',
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit new_inn_dashboard_inns_inn_bookings_path(inn_owner.id)
    fill_in 'Nome', with: ''
    fill_in 'Data Início', with: ''
    fill_in 'Data Final', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível gravar'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Data Início não pode ficar em branco'
    expect(page).to have_content 'Data Final não pode ficar em branco'
  end

  it 'successfully' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar',
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit new_inn_dashboard_inns_inn_bookings_path(inn_owner.id)
    fill_in 'Nome', with: 'Grupo Vegano'
    fill_in 'Data Início', with: 15.days.from_now
    fill_in 'Data Final', with: 20.days.from_now
    click_on 'Salvar'

    expect(page).to have_content 'Reserva salva com sucesso'
  end
end