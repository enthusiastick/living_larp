require 'spec_helper'

describe Game do

  describe "Database Tests" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:starting_points).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  describe "Validation Tests" do
    let!(:game) { FactoryGirl.create(:game) }
    it { should have_valid(:name).when("Blah blah") }
    it { should_not have_valid(:name).when(nil, "") }
    it { should validate_uniqueness_of(:name) }
    it { should have_valid(:starting_points).when(9) }
    it { should_not have_valid(:starting_points).when(nil, "") }
  end

  describe "Association Tests" do
    it { should belong_to(:user) }
    it { should have_many(:game_traits) }
    it { should have_many(:characters) }
  end

end
