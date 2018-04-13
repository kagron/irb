namespace :whenever do
  desc "Update the documents (demo)"
  task demo_task: :environment do
    puts "Updating documents..."
    documents = Document.where('created_at < ?', 90.days.ago)
    documents.each do |doc|
      doc.is_archived = 'yes'
      doc.save
    end
    puts "#{Time.now} - Success!"
  end

end
