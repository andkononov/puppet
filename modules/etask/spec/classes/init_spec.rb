require 'spec_helper'
describe 'etask' do
  context 'with default values for all parameters' do
    it { should contain_class('etask') }
  end
end
