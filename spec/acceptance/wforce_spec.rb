require 'spec_helper_acceptance'

# Currently there is no public rpm-package available
describe 'lam' do
  context 'default parameters' do
    it 'is expected to work idempotently with no errors' do
      pp = <<-EOS
      class { 'wforce':
        password => 'test',
      }
      EOS

      idempotent_apply(pp)
    end
  end
end
