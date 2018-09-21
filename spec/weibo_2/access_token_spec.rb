require 'helper'
require 'pry'

describe WeiboOAuth2::AccessToken do
  let(:api_key) { 'abc' }
  let(:api_secret) { 'def' }
  let(:access_token) do
    WeiboOAuth2::AccessToken.new(
      WeiboOAuth2::Client.new(api_key, api_secret),
      '2.00vaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      header_format: 'OAuth2 %s',
      param_name: 'access_token',
      expires_at: expires_at
    )
  end

  describe '.validated?' do
    subject { access_token.validated? }

    context 'when not gave exires_at' do
      let(:expires_at) { nil }

      it { is_expected.to be_falsy }
    end

    context 'when exired' do
      let(:expires_at) { Time.now - 86_400 }

      it { is_expected.to be_falsy }
    end

    context 'when exired yet' do
      let(:expires_at) { Time.now + 86_400 }

      it { is_expected.to be_truthy }
    end
  end
end
