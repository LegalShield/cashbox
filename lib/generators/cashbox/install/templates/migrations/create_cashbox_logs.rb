class CreateCashboxLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :cashbox_logs, id: :uuid do |t|
      t.uuid "uuid"
      t.text "operation"
      t.text "method"
      t.text "url"
      t.text "headers"
      t.text "body"

      t.timestamps
    end
  end
end
