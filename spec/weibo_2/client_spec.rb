require 'helper'

WeiboOAuth2::Config.api_key = 'abc'
WeiboOAuth2::Config.api_secret = 'def'
WeiboOAuth2::Config.redirect_uri = 'https://example.com/callback'

describe WeiboOAuth2::Client do
  describe 'initialize' do
    context 'default values' do
      it { is_expected.to have_attributes id: 'abc' }
      it { is_expected.to have_attributes secret: 'def' }
      it { is_expected.to have_attributes site: 'https://api.weibo.com/2/' }
      it { expect(subject.options[:raise_errors]).to eq true }
    end

    context 'when configrured authorize_url' do
      let(:authorize_url) do
        'https://api.weibo.com/oauth2/authorize?client_id=abc&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&response_type=code'
      end

      it { is_expected.to have_attributes authorize_url: authorize_url }
    end

    context 'when leave Faraday::Connection#ssl unset' do
      it { expect(subject.connection.ssl.empty?).to eq true }
    end


    context 'when configrured raise_errors' do
      let(:client) { OAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: raise_errors) }
      subject { client.options[:raise_errors] }

      context 'when raise_errors is false' do
        let(:raise_errors) { false }

        it { is_expected.to eq false }
      end

      context 'when raise_errors is true' do
        let(:raise_errors) { true }

        it { is_expected.to eq true }
      end
    end

    context 'when configrured access_token_method option' do
      let(:client) do
        OAuth2::Client.new('abc', 'def', site: 'https://api.example.com', access_token_method: access_token_method)
      end
      subject { client.options[:access_token_method] }

      context 'when access_token_method is get' do
        let(:access_token_method) { :get }

        it { is_expected.to eq access_token_method }
      end

      context 'when access_token_method is post' do
        let(:access_token_method) { :post }

        it { is_expected.to eq access_token_method }
      end
    end
  end
end
