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
        puts 'Logeado'
    end
end

describe "Happy Path Buscar Vuelo", :js => true, :type => :feature do
    it 'buscar vuelo' do
        visit('http://localhost:3001/')
        fill_in 'Email', with: 'Batman@gotica.com'
        fill_in 'Contraseña', with: '1234'
        click_on 'Iniciar sesión'
        select "San Francisco", from: "origen"
        select "Miami", from: "destino"
        fill_in 'fecha', with: '07/07/2022'
        click_on 'Buscar'
        click_on '+'
        page.save_screenshot

    end
end

  