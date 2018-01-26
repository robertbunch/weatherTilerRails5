class CityWeathersController < ApplicationController
  require 'json'
  before_action :set_city_weather, only: [:show, :edit, :update, :destroy]

  # GET /city_weathers
  # GET /city_weathers.json
  def index
    # Get the CityWeather model
    @city_weathers = CityWeather.all
    @days_of_week = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']

    # Get the JSON for each City
    @city_data = Array.new
    @city_weathers.each do |city_weather|
      # puts '-----------CITY WEATHER-------------'
      # puts city_weather.inspect
      # puts '------------------------------------'

      # Make sure the weather_id exists before we move on
      unless city_weather['weather_id'].nil?
        weather_data = JSON.parse(helpers.get_weather(city_weather['weather_id'],'id'))
        this_city = {
          'record' => city_weather, 
          'weather_data' => weather_data
        }
        @city_data << this_city
      end
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
    # puts "=============CITY WEATHER PARAMS============="
    # puts city_weather_params
    # puts "============================================="
    if city_weather_params['cityName'].empty?
      data = city_weather_params['zipCode']
      param = "zip"
    else
      data = city_weather_params['cityName']
      param = "q"
    end
    weather_data = JSON.parse(helpers.get_weather(data,param))

    puts "=============Code============="
    puts weather_data
    puts weather_data.instance_of? Hash
    # puts weather_data['cod']
    puts "============================================="

    unless weather_data['cod'] == '200'
      redirect_to '/city_weathers/new', alert: "Bogus City!!"
    else
      # puts "=============CREATE RESPONSE============="
      # puts city_weather_params
      # puts "========================================="
      # weather_id
      @city_weather = CityWeather.new(city_weather_params.merge(:weather_id => weather_data['city']['id']))

      # respond_to do |format|
        if @city_weather.save
          redirect_to '/', notices: "Added!"
        else
          format.html { render :new }
          format.json { render json: @city_weather.errors, status: :unprocessable_entity }
        end
      # end
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
