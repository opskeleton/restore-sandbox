require 'spec_helper'
describe 'restore' do

  context 'with defaults for all parameters' do
    it { should contain_class('restore') }
  end
end
