class CreatePollResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :poll_responses do |t|
      t.references :user, foreign_key: true
      t.text :response

      t.timestamps
    end
  end
end
