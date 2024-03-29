require 'spec_helper'

describe 'wforce' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          password: '123',
        }
      end

      it { is_expected.to compile }
    end
  end
end
