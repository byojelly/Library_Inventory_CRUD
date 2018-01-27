Library.destroy_all
Librarian.destroy_all
Section.destroy_all
Book.destroy_all
Consumer.destroy_all
#not creating the has many through has many table at the moment
Library.create!([{
                    name: "West Springfield", contact_phone: "(900) 999 - 9999", contact_email: "wsibrary@email.com", address_street: "west main st", address_city: "Springfield", address_state:"MA", address_zipcode: "12121", hours_of_operation: "M-F 9am-5pm"
                  },
                  {
                    name: "East Springfield", contact_phone: "(900) 222 - 2222", contact_email: "esibrary@email.com", address_street: "east main st", address_city: "Springfield", address_state:"MA", address_zipcode: "12121", hours_of_operation: "M-F 9am-5pm"
                  },
                  {
                    name: "North Springfield", contact_phone: "(900) 111 - 1111", contact_email: "nsibrary@email.com", address_street: "north main st", address_city: "Springfield", address_state:"MA", address_zipcode: "12121", hours_of_operation: "M-F 9am-5pm"
                  }])
  Librarian.create!([{
                    name: "Edna Krabappel", username: "krabapple", password: "pass", age: 25, start_year: 1990, library_id: 1, email: "librarian1@email.com"
                  },
                  {
                    name: "W. Seymour Skinner", username: "principal", password: "pass", age: 30, start_year: 1990, library_id: 2, email: "librarian2@email.com"
                  },
                  {
                    name: "Marion Anthony D'Amico ", username: "Fat_Tony", password: "pass", age: 40, start_year: 1990, library_id: 3, email: "librarian3@email.com"
                  }])
  Section.create!([{
                    name: "Horror", location: "Boiler Room", library_id: 1
                  },
                  {
                    name: "DIY", location: "Next to Fireplace", library_id: 1
                  },
                  {
                    name: "Non Fiction", location: "Front Desk", library_id: 1
                  },
                  {
                    name: "Horror", location: "Boiler Room", library_id: 2
                  },
                  {
                    name: "DIY", location: "Next to Fireplace", library_id: 2
                  },
                  {
                    name: "Non Fiction", location: "Front Desk", library_id: 2
                  },
                  {
                    name: "Horror", location: "Boiler Room", library_id: 3
                  },
                  {
                    name: "DIY", location: "Next to Fireplace", library_id: 3
                  },
                  {
                    name: "Non Fiction", location: "Front Desk", library_id: 3
                  }])
Consumer.create!([{
                    name: "Charles Montgomery Burns", username: "Mr. Burns", password: "excellent", age: 80, address: "1 Main St Springfield", email: "consumer1@email.com", library_id: 1
                  },
                  {

                    name: "Clarence Clancy Wiggum", username: "Chief_Wiggums", password: "donut", age: 28, address: "Springfield", email: "chief@email.com", library_id: 3
                  },
                  {
                      name: "Waylon J. Smithers Jr", username: "smithers", password: "yesmrburns", age: 40, address: "Springfield", email: "smithers@email.com", library_id: 2
                  },
                  {
                    name: "Apu Nahasapeemapetilon", username: "kwike", password: "comeagain", age: 40, address: "Springfield", email: "apu@email.com", library_id: 1
                  },
                  {
                    name: "Herschel Shmoikel Pinchas Yerucham Krustofsky", username: "Krusty", password: "clown", age: 40, address: "Springfield", email: "krusty@email.com", library_id: 3
                  },
                  {
                    name: "Moe Szyslak", username: "Moe", password: "barneyno", age: 40, address: "Moes Tavern", email: "more@email.com", library_id: 2
                  }])
Book.create!([{
                  name: "Birth of a Town: Springfield Elementary School", author: "Principal Skinner", pages: 100, available: "y", library_id: 1, section_id: 3
                },
                {
                name: "Birth of a Town: Shelbyville", author: "Principal Skinner", pages: 200, available: "y", library_id: 1, section_id: 3
              },
                {
                name: "Birth of a Town: Moe's Tavern", author: "Moe", pages: 300, available: "y", library_id: 1, section_id: 3
                },
                {
                name: "How To: Krusty Burger Empire", author: "Krusty the Clown", pages: 100, available: "y", library_id: 1, section_id: 2
                },
                {
                name: "How To: Kwik e Mart Setup", author: "Apu", pages: 200, available: "y", library_id: 1, section_id: 2
              },
                {
                name: "How To: Begin Your Empire Today", author: "Mr. Burns", pages: 300, available: "y", library_id: 1, section_id: 2
                },
                {
                name: "Beware: House of Horrors Part 1", author: "Smithers", pages: 100, available: "y", library_id: 1, section_id: 1
                },
                {
                name: "Beware: House of Horrors Part 2", author: "Apu", pages: 200, available: "y", library_id: 1, section_id: 1
              },
                {
                name: "Beware: House of Horrors Part 3", author: "Mr. Burns", pages: 300, available: "y", library_id: 1, section_id: 1
              },
              {
              name: "Birth of a Town: Springfield Elementary School", author: "Principal Skinner", pages: 100, available: "y", library_id: 2, section_id: 3
            },
            {
            name: "Birth of a Town: Shelbyville", author: "Principal Skinner", pages: 200, available: "y", library_id: 2, section_id: 3
          },
            {
            name: "Birth of a Town: Moe's Tavern", author: "Moe", pages: 300, available: "y", library_id: 2, section_id: 3
            },
            {
            name: "How To: Krusty Burger Empire", author: "Krusty the Clown", pages: 100, available: "y", library_id: 2, section_id: 2
            },
            {
            name: "How To: Kwik e Mart Setup", author: "Apu", pages: 200, available: "y", library_id: 2, section_id: 2
          },
            {
            name: "How To: Begin Your Empire Today", author: "Mr. Burns", pages: 300, available: "y", library_id: 2, section_id: 2
            },
            {
            name: "Beware: House of Horrors Part 1", author: "Smithers", pages: 100, available: "y", library_id: 2, section_id: 1
            },
            {
            name: "Beware: House of Horrors Part 2", author: "Apu", pages: 200, available: "y", library_id: 2, section_id: 1
          },
            {
            name: "Beware: House of Horrors Part 3", author: "Mr. Burns", pages: 300, available: "y", library_id: 2, section_id: 1
          },
          {
          name: "Birth of a Town: Springfield Elementary School", author: "Principal Skinner", pages: 100, available: "y", library_id: 3, section_id: 3
        },
        {
        name: "Birth of a Town: Shelbyville", author: "Principal Skinner", pages: 200, available: "y", library_id: 3, section_id: 3
      },
        {
        name: "Birth of a Town: Moe's Tavern", author: "Moe", pages: 300, available: "y", library_id: 3, section_id: 3
        },
        {
        name: "How To: Krusty Burger Empire", author: "Krusty the Clown", pages: 100, available: "y", library_id: 3, section_id: 2
        },
        {
        name: "How To: Kwik e Mart Setup", author: "Apu", pages: 200, available: "y", library_id: 3, section_id: 2
      },
        {
        name: "How To: Begin Your Empire Today", author: "Mr. Burns", pages: 300, available: "y", library_id: 3, section_id: 2
        },
        {
        name: "Beware: House of Horrors Part 1", author: "Smithers", pages: 100, available: "y", library_id: 3, section_id: 1
        },
        {
        name: "Beware: House of Horrors Part 2", author: "Apu", pages: 200, available: "y", library_id: 3, section_id: 1
      },
        {
        name: "Beware: House of Horrors Part 3", author: "Mr. Burns", pages: 300, available: "y", library_id: 3, section_id: 1
                }])
