require 'spec_helper'

describe GameTraitDependency do

  describe "Database Tests" do
    it { should have_db_column(:parent_trait_id).of_type(:integer) }
    it { should have_db_column(:child_trait_id).of_type(:integer) }
    it { should have_db_index([:parent_trait_id, :child_trait_id]).unique(true) }
  end

  describe "Association Tests" do
    it { should belong_to(:parent_trait) }
    it { should belong_to(:child_trait) }
  end

end
