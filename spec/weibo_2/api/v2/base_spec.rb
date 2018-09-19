require 'helper'
require 'pry'

describe WeiboOAuth2::Api::V2::Base do
  let(:access_token) do
    WeiboOAuth2::AccessToken.new(
      self, 'access_token', header_format: 'OAuth2 %s', param_name: 'access_token'
    )
  end

  describe '.hashie' do
    let(:base) { WeiboOAuth2::Api::V2::Base.new access_token }
    subject { base.hashie OpenStruct.new body: response.to_json }

    context 'when response value is Hash' do
      let(:response) { { foo: { bar: 1 } } }

      it { is_expected.to have_attributes foo: response[:foo] }
    end
  end
end
