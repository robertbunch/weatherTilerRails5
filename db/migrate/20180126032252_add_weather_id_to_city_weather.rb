class AddWeatherIdToCityWeather < ActiveRecord::Migration[5.1]
  def change
  	add_column :city_weathers, :weather_id, :integer
  end
end
