require 'spec_helper'

describe GameTrait do

  describe "Database Tests" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:max_purchases).of_type(:integer) }
    it { should have_db_column(:bgs).of_type(:boolean) }
    it { should have_db_column(:point_cost).of_type(:integer) }
    it { should have_db_column(:game_id).of_type(:integer) }
  end

  describe "Validation Tests" do
    it { should have_valid(:name).when("Blah blah") }
    it { should_not have_valid(:name).when(nil, "") }
    it { should have_valid(:point_cost).when(9) }
    it { should_not have_valid(:point_cost).when(nil, "") }
  end

  describe "Association Tests" do
    it { should belong_to(:game) }
    it { should have_many(:traits) }
    it { should have_many(:characters).through(:traits) }
    it { should have_many(:game_trait_dependencies) }
    it { should have_many(:parent_traits).through(:game_trait_dependencies) }
  end

end
