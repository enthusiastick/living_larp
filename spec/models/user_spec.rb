require 'spec_helper'

describe User do
  it { should have_valid(:email).when('foo@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'chuck', 'chuck@u', 'chuck.far') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'another password'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
