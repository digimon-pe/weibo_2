require 'helper'
require 'pry'

describe WeiboOAuth2::Client do
  let(:api_key) { 'abc' }
  let(:api_secret) { 'def' }
  let(:redirect_uri) { 'https://example.com/callback' }
  before do
    WeiboOAuth2::Config.api_key = api_key
    WeiboOAuth2::Config.api_secret = api_secret
    WeiboOAuth2::Config.redirect_uri = redirect_uri
  end

  describe 'initialize' do
    context 'when gave arguments' do
      subject { WeiboOAuth2::Client.new 'client_id', 'client_secret' }

      it { is_expected.to have_attributes id: 'client_id' }
      it { is_expected.to have_attributes secret: 'client_secret' }
      it { is_expected.to have_attributes options: include(authorize_url: '/oauth2/authorize') }
      it { is_expected.to have_attributes options: include(token_url: '/oauth2/access_token') }
    end

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

  describe '#from_code' do
    let(:authorization_code) { 'hoge' }
    subject { WeiboOAuth2::Client.from_code(authorization_code) }
    around do |example|
      VCR.use_cassette(cassette) { example.run }
    end

    context 'when invalid id' do
      let(:cassette) { 'client/form_code/invalid_id' }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::GeneralError }
    end

    context 'when token expired' do
      let(:cassette) { 'client/form_code/unauthorized_error' }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::UnauthorizedError }
    end

    context 'when IP requests out of rate limit' do
      let(:cassette) { 'client/form_code/rate_limited_error' }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::RateLimitedError }
    end

    context 'when invalid weibo user' do
      let(:cassette) { 'client/form_code/permission_error' }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::PermissionError }
    end

    context 'when invalid authorization code' do
      let(:cassette) { 'client/form_code/invalid_authorization_code' }
      let(:api_key) { '0000000000' }
      let(:api_secret) { 'very_secret' }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::GeneralError }
    end

    context 'when valid request' do
      let(:cassette) { 'client/form_code/valid_request' }
      let(:authorization_code) { 'valid_code' }
      let(:api_key) { '0000000000' }
      let(:api_secret) { 'very_secret' }

      it { is_expected.to have_attributes access_token: be_a(OAuth2::AccessToken) }
    end
  end

  describe '#from_hash' do
    let(:access_token) { { access_token: 'foo' } }
    subject { WeiboOAuth2::Client.from_hash(access_token) }

    it { is_expected.to have_attributes access_token: be_a(OAuth2::AccessToken) }
  end

  describe '.users' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.users }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Users }
    end
  end

  describe '.statuses' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.statuses }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Statuses }
    end
  end

  describe '.comments' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.comments }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Comments }
    end
  end

  describe '.friendships' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.friendships }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Friendships }
    end
  end

  describe '.account' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.account }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Account }
    end
  end

  describe '.favorites' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.favorites }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Favorites }
    end
  end

  describe '.trends' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.trends }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Trends }
    end
  end

  describe '.tags' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.tags }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Tags }
    end
  end

  describe '.register' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.register }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Register }
    end
  end

  describe '.search' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.search }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Search }
    end
  end

  describe '.short_url' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.short_url }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::ShortUrl }
    end
  end

  describe '.suggestions' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.suggestions }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Suggestions }
    end
  end

  describe '.remind' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.remind }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Remind }
    end
  end

  describe '.auth_code' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.auth_code }

    it { is_expected.to be_a WeiboOAuth2::Strategy::AuthCode }
  end

  describe '.place' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.place }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Place }
    end
  end

  describe '.location' do
    let(:client) { WeiboOAuth2::Client.new('abc', 'def', site: 'https://api.example.com', raise_errors: true) }
    subject { client.location }

    context 'when not set access_token' do
      it { is_expected.to eq nil }
    end

    context 'when not set access_token' do
      before { client.get_token_from_hash access_token: 'foo' }

      it { is_expected.to be_a WeiboOAuth2::Api::V2::Location }
    end
  end
end
