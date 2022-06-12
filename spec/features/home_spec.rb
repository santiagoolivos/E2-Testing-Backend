


describe "GET '/' - homepage title", :type => :feature do
    it 'welcomes the user to React App' do
        visit('http://localhost:3001/')
        expect(page.title).to have_content("React App")
        puts 'the homepage title is React App'
    end
end

describe "Registrarse", :js => true, :type => :feature do
    it 'registrarse' do
        visit('http://localhost:3001/')
        click_on 'Registrarse'
        fill_in 'Nombre', with: 'Batman'
        fill_in 'Apellido', with: 'Alvarez'
        fill_in 'Email', with: 'Batman@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Registrarse'
        # page.save_screenshot
        expect(page).to have_content("Inicio Sesión")
        puts 'Registrado'
    end
end

describe "Log In", :js => true, :type => :feature do
    it 'registrarse' do
        visit('http://localhost:3001/')
        fill_in 'Email', with: 'Batman@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        # page.save_screenshot
        expect(page).to have_content("Mis Vuelos")
        puts 'Logeado'
    end
end

describe "Happy Path Buscar Vuelo", :js => true, :type => :feature do
    it 'buscar vuelo' do
        visit('http://localhost:3001/')
        fill_in 'Email', with: 'Batman@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        select "Los Angeles", from: "origen"
        select "Chicago", from: "destino"
        fill_in 'fecha', with: '07/09/2022'
        click_on 'Buscar'
        expect(page).to have_content("Seleccionar asientos")

    end
end

describe "Happy Path Reservar Vuelo", :js => true, :type => :feature do
    it 'buscar vuelo' do
        visit('http://localhost:3001/')
        fill_in 'Email', with: 'Batman@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        select "Los Angeles", from: "origen"
        select "Chicago", from: "destino"
        fill_in 'fecha', with: '07/09/2022'
        click_on 'Buscar'
        click_on 'Seleccionar asientos'
        find('#A10').click
        fill_in 'nombre_pasajero', with: 'Tomás'
        click_on 'Agregar Asientos'
        expect(page).to have_content("A10")
    end
end
  