class ChangeBodyNullInSentences < ActiveRecord::Migration[7.0]
  def change
    change_column_null :sentences, :body, true
    change_column_default :sentences, :body, nil
  end
end
