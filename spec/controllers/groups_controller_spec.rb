require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  # Sending request to add non-existent user to group should not change Memberships count
  # create group
  let!(:group) { create(:group) }
  # create user
  let!(:user) { create(:user) }
  # create membership
  let!(:membership) { create(:membership, group: group, user: user)}
  
  # sign_in
  before(:each) do
    sign_in user
  end

  describe 'POST create' do
    let(:post_invitation) { post :create_user, user: { email: "empty" }, id: group.id }

    context 'when user is not registered' do
      it 'does not create membership' do
        expect { post_invitation }.to_not change(Membership, :count)
      end
    end
  end

end
