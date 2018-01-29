namespace :whenever do
  desc "Update the documents (demo)"
  task demo_task: :environment do
    puts "Updating documents..."
    Document.all
    puts "#{Time.now} - Success!"
  end

end
