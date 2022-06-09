# frozen_string_literal: true

User.find_or_create_by(name: 'admin', lastname: 'admin', username: 'admin@admin.cl', role: 1,
                       password_digest: BCrypt::Password.create('admin'))
User.find_or_create_by(name: 'Benja', lastname: 'Alamos', username: 'balamos@user.cl', role: 2,
                       password_digest: BCrypt::Password.create('benja'))
User.find_or_create_by(name: 'Juan', lastname: 'Perez', username: 'juan@user.cl', role: 2,
                       password_digest: BCrypt::Password.create('juan'))
User.find_or_create_by(name: 'Pedro', lastname: 'Perez', username: 'pedro@user.cl', role: 2,
                       password_digest: BCrypt::Password.create('pedro'))
User.find_or_create_by(name: 'Santiago', lastname: 'Olivos', username: 'santiago@user.cl', role: 2,
                       password_digest: BCrypt::Password.create('santiago'))
