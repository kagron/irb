class AddAttachmentsToDocument < ActiveRecord::Migration[5.1]
  def change
      add_column :documents, :questions_file, :string
      add_column :documents, :consent_file, :string
      add_column :documents, :child_assent_file, :string
      add_column :documents, :hsr_certificate_file, :string
      add_column :documents, :written_permission, :string
  end
end
