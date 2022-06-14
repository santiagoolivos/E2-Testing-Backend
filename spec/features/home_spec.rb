require "database_cleaner/active_record"



describe "GET '/' - homepage title", :type => :feature do
    it 'welcomes the user to React App' do
        visit('https://main--magnificent-queijadas-851f64.netlify.app/')
        expect(page.title).to have_content("React App")
        puts 'the homepage title is React App'
    end
end

describe "Registrarse", :js => true, :type => :feature do
    it 'registrarse' do
        visit('https://main--magnificent-queijadas-851f64.netlify.app/')
        click_on 'Registrarse'
        fill_in 'Nombre', with: 'Batman'
        fill_in 'Apellido', with: 'Alvarez'
        fill_in 'Email', with: 'Batman2@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Registrarse'
        # page.save_screenshot
        expect(page).to have_content("Inicio Sesión")
        puts 'Registrado'
    end
end

describe "Log In", :js => true, :type => :feature do
    it 'registrarse' do
        visit('https://main--magnificent-queijadas-851f64.netlify.app/')
        fill_in 'Email', with: 'Batman2@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        # page.save_screenshot
        expect(page).to have_content("Mis Vuelos")
        puts 'Logeado'
    end
end

describe "Happy Path Buscar Vuelo", :js => true, :type => :feature do
    it 'buscar vuelo' do
        visit('https://main--magnificent-queijadas-851f64.netlify.app/')
        fill_in 'Email', with: 'Batman2@gotica.com'
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
        visit('https://main--magnificent-queijadas-851f64.netlify.app/')
        fill_in 'Email', with: 'Batman2@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        select "Los Angeles", from: "origen"
        select "Chicago", from: "destino"
        fill_in 'fecha', with: '07/09/2022'
        click_on 'Buscar'
        click_on 'Seleccionar asientos'
        print("Si este test falla es posible que sea debido a que el asiento ya está seleccionado. Por favor intentar con un asiento disponible.")
        find('#D3').click
        fill_in 'nombre_pasajero', with: 'Tomás'
        click_on 'Agregar Asientos'
        expect(page).to have_content("Tomás")
    end
end
  