require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:group) { create(:group) }
  let!(:recipe) { create(:recipe, user_id: user.id, group_id: group.id) }
  let!(:recipe_member) { create(:recipe_member, recipe_id: recipe.id, user_id: user2.id) }
  let!(:membership) { create(:membership, group: group, user: user)}

  before(:each) do
    sign_in user
  end

  describe 'POST balance_user' do
    context 'when balancing user recipe' do
      it 'respond with zero in balance' do
        post :balance_user,  user_id: user2.id, id: group.id
        recipe_member.reload
        expect(recipe_member.balance).to eq(true)
      end
    end
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
