class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :fName
      t.string :lName
      t.string :phone
      t.string :email
      t.string :address
      t.string :department
      t.integer :typeOfApplication
      t.string :project_title
      t.string :sponsor_name
      t.date :start_date
      t.date :end_date
      t.string :research_question
      t.text :lit_review
      t.text :procedure
      t.text :pool_of_subjects
      t.text :sub_recruitment
      t.text :risks
      t.text :opt_participation
      t.text :confidentiality
      t.text :authorities_consent
      t.text :subjects_consent
      t.text :parental_consent
      t.string :advisor_sig

      t.timestamps
    end
  end
end
