require 'spec_helper'
describe 'sauron' do

  context 'with defaults for all parameters' do
    it { should contain_class('sauron') }
  end
end
