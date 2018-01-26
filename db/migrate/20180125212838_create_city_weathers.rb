class CreateCityWeathers < ActiveRecord::Migration[5.1]
  def change
    create_table :city_weathers do |t|
      t.string :cityName
      t.integer :zipCode
      t.text :desc

      t.timestamps
    end
  end
end
