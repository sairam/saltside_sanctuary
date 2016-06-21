class Api::BirdsController < ApiController
  def show
    bird = Bird.find(params[:id])
    render json: bird
  end

  def index
    render json: Bird.visible.pluck(:id).map(&:to_s)
  end

  def create
    bird = Bird.new(bird_params)
    if bird.save
      headers['location'] = api_bird_path(bird.id)
      render json: bird, status: 201
    else
      render json: bird.errors.full_messages, status: 400
    end
  rescue JSON::ParserError
    render json: {message: 'Malformed Input'}, status: 400
  end

  def destroy
    Bird.find(params[:id]).destroy
    render json: {}
  end

  def bird_params
    request_params = JSON.parse(request.env['RAW_POST_DATA'])
    ActionController::Parameters.new(request_params).permit(*permitted_bird_attributes)
  end

  def permitted_bird_attributes
    [:name, :family, :added, :visible, :continents => []]
  end

end
