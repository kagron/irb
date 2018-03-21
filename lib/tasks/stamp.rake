namespace :stamp do
  desc "Creating a stamp each day"
  task stamp_task: :environment do
    puts "Creating stamp..."
    Prawn::Document.generate("stamp.pdf") do
      text "Approved"
      text "#{Time.now.strftime("%B %d %Y")}"
      text "Valid for 1 year"
    end
    puts "#{Time.now} - Success!"
  end

end
