require 'rails_helper'

describe Api::BirdsController do
  context 'POST create' do
    it 'with required params'
    it 'with required + added params'
    it 'with required + visible params'
    it 'fails when input is invalid'
    it 'fails when required fields are missing'
    it 'fails when visible is not boolean'
    it 'fails when added is not in the required format'
  end

  context 'DELETE destroy' do
    it 'an existing bird' do
      bird = create(:bird)
      delete :destroy, id: bird.id
      expect(response).to have_http_status(200)
    end
    it 'an existing invisible bird' do
      bird = create(:invisible_bird)
      delete :destroy, id: bird.id
      expect(response).to have_http_status(200)
    end
    it 'an unknown bird' do
      delete :destroy, id: '1234'
      expect(response).to have_http_status(404)
    end
  end

  context 'GET index' do
    it 'returns empty list' do
      get :index
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      expect(data.size).to eq(0)
    end
    it 'no invisible birds' do
      create(:invisible_bird)
      get :index
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      expect(data.size).to eq(0)
    end

    it 'only visible birds' do
      create(:invisible_bird)
      create(:bird)
      get :index
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      expect(data.size).to eq(1)
    end
  end

  context 'GET show' do
    it 'fails when bird is not present' do
      get :show, id: '1234'
      expect(response).to have_http_status(404)
    end

    it 'success' do
      bird = create(:bird)
      get :show, id: bird.id
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      match(bird, data, %w{added continents family name visible})
    end
  end

  def match(object, response, attributes)
    attributes.each do |attribute|
      expect(object.send(attribute)).to eq(response[attribute])
    end
  end
end
