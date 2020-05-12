User.create!(name:  "管理者",
             id: 2,
             email: "admin@g.ccc",
             password:  "adminadmin",
             password_confirmation: "adminadmin",
             admin: true)

         
User.create!(name:  "sample",
             id 1,
             email: "sample@example.com",
             password:  "00000000",
             password_confirmation: "00000000",
             admin: false)