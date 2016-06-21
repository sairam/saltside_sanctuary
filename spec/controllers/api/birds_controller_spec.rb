require 'rails_helper'

describe Api::BirdsController do
  context 'POST create' do
    it 'with all params' do
      expect {
        bird = build(:bird)
        params = bird.serializable_hash.tap {|x| x.delete("id") }
        post :create, params.to_json, { format: 'json'}
        expect(response).to have_http_status(201)
        data = JSON.parse(response.body)
        match(bird, data, %w{added continents family name visible})
      }.to change(Bird,:count).by(1)
    end

    it 'with required params' do
      expect {
        bird = build(:bird)
        params = bird.serializable_hash.tap {|x| %w{id visible added}.each{|a| x.delete(a) } }
        post :create, params.to_json, { format: 'json'}
        expect(response).to have_http_status(201)
        data = JSON.parse(response.body)
        match(bird, data, %w{continents family name})
      }.to change(Bird,:count).by(1)
    end

    it 'fails when input is invalid' do
      bird = build(:bird)
      params = bird.serializable_hash.tap {|x| %w{id}.each{|a| x.delete(a) } }
      malformed_json_data = params.to_json[0..-9]
      post :create, malformed_json_data, { format: 'json'}
      expect(response).to have_http_status(400)
      expect(response.body).to include('Malformed Input')
    end

    it 'fails when required fields are missing' do
      bird = build(:bird)
      %w{continents name family}.each do |required_field|
        params = bird.serializable_hash.tap {|x| [required_field, "id"].each{|a| x.delete(a) } }
        post :create, params.to_json, { format: 'json'}
        expect(response).to have_http_status(400)
        expect(response.body).to include(required_field.camelize)
      end
    end

    it 'with added is malformed' do
      bird = build(:bird, added: '2015 12 12')
      params = bird.serializable_hash.tap {|x| %w{id}.each{|a| x.delete(a) } }
      post :create, params.to_json, { format: 'json'}
      expect(response).to have_http_status(400)
      expect(response.body).to include('Added is not a valid date')
    end
  end

  context 'DELETE destroy' do
    it 'an existing bird' do
      bird = create(:bird)
      expect {
        delete :destroy, id: bird.id
        expect(response).to have_http_status(200)
      }.to change(Bird,:count).by(-1)
    end
    it 'an existing invisible bird' do
      bird = create(:invisible_bird)
      expect {
        delete :destroy, id: bird.id
        expect(response).to have_http_status(200)
      }.to change(Bird,:count).by(-1)
    end
    it 'an unknown bird' do
      expect {
        delete :destroy, id: '1234'
        expect(response).to have_http_status(404)
      }.to change(Bird,:count).by(0)
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
    it 'only visible birds' do
      5.times { create(:bird) }
      get :index
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      expect(data.size).to eq(5)
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
