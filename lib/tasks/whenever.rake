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
    puts "Checking applications that are over a year..."
    documents = Document.find_by_sql("select * from documents where datediff(start_date, end_date) <= -365 and datediff(curdate(), end_date) = -7")
    documents.each do |doc|
      UserEmailMailer.yearlong(@document).deliver
      UserEmailMailer.yearlongresubmit(@document).deliver
    end
  end

end
