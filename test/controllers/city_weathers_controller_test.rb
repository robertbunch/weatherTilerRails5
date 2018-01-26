require 'test_helper'

class CityWeathersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city_weather = city_weathers(:one)
  end

  test "should get index" do
    get city_weathers_url
    assert_response :success
  end

  test "should get new" do
    get new_city_weather_url
    assert_response :success
  end

  test "should create city_weather" do
    assert_difference('CityWeather.count') do
      post city_weathers_url, params: { city_weather: { cityName: @city_weather.cityName, desc: @city_weather.desc, zipCode: @city_weather.zipCode } }
    end

    assert_redirected_to city_weather_url(CityWeather.last)
  end

  test "should show city_weather" do
    get city_weather_url(@city_weather)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_weather_url(@city_weather)
    assert_response :success
  end

  test "should update city_weather" do
    patch city_weather_url(@city_weather), params: { city_weather: { cityName: @city_weather.cityName, desc: @city_weather.desc, zipCode: @city_weather.zipCode } }
    assert_redirected_to city_weather_url(@city_weather)
  end

  test "should destroy city_weather" do
    assert_difference('CityWeather.count', -1) do
      delete city_weather_url(@city_weather)
    end

    assert_redirected_to city_weathers_url
  end
end
