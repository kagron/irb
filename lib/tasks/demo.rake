namespace :demo do
    desc "Demo running a rake task"
    task say_hello: :environment do
        puts "Hello"
    end
end