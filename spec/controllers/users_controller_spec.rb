require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'PATCH /user' do
    context 'successful update' do
      it "reponds with suceess" do
        api_user user

        patch :update, {}

        expect(response).to be_success
      end

      it "returns user data" do
        api_user user

        patch :update, {}

        expect(response.body).to serialize_object(user)
          .with(UserSerializer, :include => ['organization', 'badges'])
      end

      it "updates user's information" do
        organization = create(:organization)

        api_user user

        patch :update, { organization_id: organization.id }

        expect(json['data']['relationships']['organization']['data']['id']).to eq(organization.id.to_s)
      end
    end
  end

  describe 'GET /user' do
    context 'with a successful call' do
      it "reponds with suceess" do
        api_user user

        get :show

        expect(response).to be_success
      end

      it "returns user data" do
        api_user user

        get :show

        expect(response.body).to serialize_object(user)
          .with(UserSerializer, :include => ['organization', 'badges'])
      end
    end
  end
end
