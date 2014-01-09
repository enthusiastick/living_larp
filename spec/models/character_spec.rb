require 'spec_helper'

describe Character do

  describe "Database Tests" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:available_points).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:game_id).of_type(:integer) }
  end

  describe "Validation Tests" do
    it { should have_valid(:name).when("Blah blah") }
    it { should_not have_valid(:name).when(nil, "") }
  end

  describe "Association Tests" do
    it { should belong_to(:game) }
    it { should belong_to(:user) }
  end

end
