require 'spec_helper'

describe Game do

  describe "Database Tests" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:starting_points).of_type(:integer) }
  end

  describe "Validation Tests" do
    it { should have_valid(:name).when("Blah blah") }
    it { should_not have_valid(:name).when(nil, "") }
    it { should have_valid(:starting_points).when(9) }
    it { should_not have_valid(:starting_points).when(nil, "") }
  end

  # describe "Association Tests" do
  #   it { should belong_to(:user) }
  # end

end
