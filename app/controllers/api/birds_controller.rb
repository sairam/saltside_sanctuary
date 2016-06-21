class Api::BirdsController < ApiController
  def show
    bird = Bird.find(params[:id])
    render json: bird
  end

  def index
    render json: Bird.visible.pluck(:id).map(&:to_s)
  end

  def create
    bird = Bird.new(params)
    if bird.save
      headers['location'] = api_bird_path(bird.id)
      render json: bird, status: 201
    else
      render json: bird.errors, status: 400
    end
  end

  def destroy
    Bird.find(params[:id]).destroy
    render json: {}
  end

end
