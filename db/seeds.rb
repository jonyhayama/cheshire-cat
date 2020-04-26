# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def colorize(string, color)
  case color.to_sym
    when :red
      "\e[31m#{string}\e[0m"
    when :blue
      "\e[34m#{string}\e[0m"
    when :green
      "\e[32m#{string}\e[0m"
    else 
      string
  end
end

data = [{
    "ip": "1.1.1.1",
    "hostnames_attributes": [
      { "name": "lorem.com" },
      { "name": "ipsum.com" },
      { "name": "dolor.com" },
      { "name": "amet.com" },
    ]
  },
  {
    "ip": "2.2.2.2",
    "hostnames_attributes": [
      { "name": "ipsum.com" },
    ]
  },
  {
    "ip": "3.3.3.3",
    "hostnames_attributes": [
      { "name": "ipsum.com" },
      { "name": "dolor.com" },
      { "name": "amet.com" },
    ]
  },
  {
    "ip": "4.4.4.4",
    "hostnames_attributes": [
      { "name": "ipsum.com" },
      { "name": "dolor.com" },
      { "name": "sit.com" },
      { "name": "amet.com" },
    ]
  },
  {
    "ip": "5.5.5.5",
    "hostnames_attributes": [
      { "name": "dolor.com" },
      { "name": "sit.com" },
    ]
  }
]

data.each do |info|
  record = Record.new(info)
  puts colorize("Creating IP #{info[:ip]}...", :blue)
  if record.save
    puts colorize("SUCCESS [ID: #{record.id}]", :green)
  else
    puts colorize("ERROR(s):", :red)
    record.errors.full_messages.each{ |m| puts "- #{m}" }
  end
  puts "\n"
end
