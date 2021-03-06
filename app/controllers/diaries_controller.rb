# class DiariesController < OpenReadController
class DiariesController < ProtectedController
  WEATHER_API = 'http://api.openweathermap.org/data/2.5/weather?q=Boston,us&appid=f1c0d3b7cb3bd30991614b391a2ddf52'.freeze
  # skip_before_action :authenticate, only: :create
  before_action :set_diary, only: [:show, :update, :destroy]

  # GET /diaries
  # GET /diaries.json
  def index
    @diaries = Diary.all

    render json: @diaries
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
    render json: @diary
  end

  # POST /diaries
  # POST /diaries.json
  # def create
  #   @diary = Diary.new(diary_params)

  def create
    with_weather = diary_params.merge(weather: get_weather)

    @diary = current_user.diaries.build(with_weather)
    if @diary.save
      render json: @diary, status: :created, location: @diary
    else
      render json: @diary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    # @diary = Diary.find(params[:id])

    if @diary.update(diary_params)
      head :no_content
    else
      render json: @diary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary.destroy

    head :no_content
  end

  private

    def get_weather
      resp = HTTParty.get WEATHER_API
      resp['weather'][0]['icon']
    end

    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:title, :content, :weather)
    end
end
