class CityWeathersController < ApplicationController
  before_action :set_city_weather, only: [:show, :edit, :update, :destroy]

  # GET /city_weathers
  # GET /city_weathers.json
  def index
    puts "==============================="
    # puts Rails.application.secrets
    puts Rails.application.config_for(:weather)
    puts "==============================="
    @city_weathers = CityWeather.all
    require 'net/http'
    require 'json'
    @city_data = Array.new
    @city_weathers.each do |city_weather|
      url = 'http://api.openweathermap.org/data/2.5/weather?id=524901&appid=e312dbeb8840e51f92334498a261ca1d&units=imperial'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      this_city = {
        'record' => city_weather, 
        'weatherData' => JSON.parse(response)
      }
      @city_data << this_city
    end
  end

  # GET /city_weathers/1
  # GET /city_weathers/1.json
  def show
  end

  # GET /city_weathers/new
  def new
    @city_weather = CityWeather.new
  end

  # GET /city_weathers/1/edit
  def edit
  end

  # POST /city_weathers
  # POST /city_weathers.json
  def create
    @city_weather = CityWeather.new(city_weather_params)

    respond_to do |format|
      if @city_weather.save
        format.html { redirect_to @city_weather, notice: 'City weather was successfully created.' }
        format.json { render :show, status: :created, location: @city_weather }
      else
        format.html { render :new }
        format.json { render json: @city_weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_weathers/1
  # PATCH/PUT /city_weathers/1.json
  def update
    respond_to do |format|
      if @city_weather.update(city_weather_params)
        format.html { redirect_to @city_weather, notice: 'City weather was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_weather }
      else
        format.html { render :edit }
        format.json { render json: @city_weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_weathers/1
  # DELETE /city_weathers/1.json
  def destroy
    @city_weather.destroy
    respond_to do |format|
      format.html { redirect_to city_weathers_url, notice: 'City weather was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_weather
      @city_weather = CityWeather.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_weather_params
      params.require(:city_weather).permit(:cityName, :zipCode, :desc)
    end
end
