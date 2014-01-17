require 'spec_helper'

describe Player do

  describe "Database Tests" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:game_id).of_type(:integer) }
    it { should have_db_column(:points).of_type(:integer) }
    it { should have_db_index([:game_id, :user_id]).unique(true) }
  end

  describe "Validation Tests" do
    # it { should validate_numericality_of(:points).only_integer.is_greater_than_or_equal_to(0) }
    # it { should validate_uniqueness_of(:user).scope(:game) }
  end

  describe "Association Tests" do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
    it { should have_many(:characters) }
  end

end
