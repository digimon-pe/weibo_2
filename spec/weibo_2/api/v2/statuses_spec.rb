require 'helper'

describe WeiboOAuth2::Api::V2::Statuses do
  let(:api_key) { 'abc' }
  let(:api_secret) { 'def' }
  let(:redirect_uri) { 'https://example.com/callback' }
  before do
    WeiboOAuth2::Config.api_key = api_key
    WeiboOAuth2::Config.api_secret = api_secret
    WeiboOAuth2::Config.redirect_uri = redirect_uri
  end
  around do |example|
    VCR.use_cassette(cassette) { example.run }
  end
  let(:access_token) do
    WeiboOAuth2::AccessToken.new(
      WeiboOAuth2::Client.new(api_key, api_secret),
      '2.00vaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      header_format: 'OAuth2 %s',
      param_name: 'access_token'
    )
  end
  let(:statuses) { WeiboOAuth2::Api::V2::Statuses.new access_token }

  shared_examples 'request_without_required_options' do
    context 'when without options' do
      let(:cassette) { "api/v2/#{request_directry}/without_options" }
      let(:options) { {} }

      it do
        expect(
          a_request(:get, "#{access_token.client.site + request_directry}.json")
        ).to have_been_made.once
      end
    end

    context 'when with options' do
      let(:cassette) { "api/v2/#{request_directry}/with_options" }

      it do
        expect(
          a_request(:get, "#{access_token.client.site + request_directry}.json?#{URI.encode_www_form options}")
        ).to have_been_made.once
      end
    end
  end

  shared_examples 'request_with_weibo_user_id' do
    context 'when without weibo user id' do
      let(:cassette) { "api/v2/#{request_directry}/without_options" }
      let(:id) { nil }
      let(:options) { {} }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::GeneralError }
    end

    context 'when with options' do
      let(:cassette) { "api/v2/#{request_directry}/with_options" }
      let(:id) { 1_111_111_111 }
      before { subject }

      it do
        expect(
          a_request(
            :get,
            "#{access_token.client.site + request_directry}.json?#{URI.encode_www_form options.merge(id: id)}"
          )
        ).to have_been_made.once
      end
    end
  end

  describe '.public_timeline' do
    before { statuses.public_timeline(options) }
    let(:request_directry) { 'statuses/public_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.friends_timeline' do
    before { statuses.friends_timeline(options) }
    let(:request_directry) { 'statuses/friends_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.home_timeline' do
    before { statuses.home_timeline(options) }
    let(:request_directry) { 'statuses/home_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.friends_timeline_ids' do
    before { statuses.friends_timeline_ids(options) }
    let(:request_directry) { 'statuses/friends_timeline/ids' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.user_timeline' do
    before { statuses.user_timeline(options) }
    let(:request_directry) { 'statuses/user_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.user_timeline_ids' do
    before { statuses.user_timeline_ids(options) }
    let(:request_directry) { 'statuses/user_timeline/ids' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.repost_timeline' do
    subject { statuses.repost_timeline(id, options) }
    let(:request_directry) { 'statuses/repost_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_with_weibo_user_id'
  end

  describe '.repost_timeline_ids' do
    subject { statuses.repost_timeline_ids(id, options) }
    let(:request_directry) { 'statuses/repost_timeline/ids' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_with_weibo_user_id'
  end

  describe '.repost_by_me' do
    before { statuses.repost_by_me(options) }
    let(:request_directry) { 'statuses/repost_by_me' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.mentions' do
    before { statuses.mentions(options) }
    let(:request_directry) { 'statuses/mentions' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.mentions_ids' do
    before { statuses.mentions_ids(options) }
    let(:request_directry) { 'statuses/mentions/ids' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.bilateral_timeline' do
    before { statuses.bilateral_timeline(options) }
    let(:request_directry) { 'statuses/bilateral_timeline' }
    let(:options) { { count: 5, page: 2 } }

    it_behaves_like 'request_without_required_options'
  end

  describe '.show' do
    subject { statuses.show(id, options) }
    let(:request_directry) { 'statuses/show' }
    let(:options) { {} }

    it_behaves_like 'request_with_weibo_user_id'
  end

  describe '.querymid' do
    subject { statuses.querymid(id, type, options) }
    let(:type) { 1 }
    let(:request_directry) { 'statuses/querymid' }

    context 'when without weibo user id' do
      let(:cassette) { "api/v2/#{request_directry}/without_options" }
      let(:id) { nil }
      let(:options) { {} }

      it { is_expected.to have_attributes mid: '' }
    end

    context 'when with options' do
      let(:cassette) { "api/v2/#{request_directry}/with_options" }
      let(:id) { 1_111_111_111 }
      let(:options) { { is_batch: 0 } }
      before { subject }

      it do
        params = URI.encode_www_form options.merge id: id, type: type
        expect(
          a_request(
            :get,
            "#{access_token.client.site + request_directry}.json?#{params}"
          )
        ).to have_been_made.once
      end
    end
  end

  describe '.share' do
    let(:request_directry) { 'statuses/share' }
    let(:status) { 'my post http://example.com' }
    let(:pic) { fixture('attachment/upload.png') }
    let(:options) { {} }
    subject { statuses.share status, pic, options }

    context 'when valid access_token' do
      let(:cassette) { "api/v2/#{request_directry}/valid_access_token" }
      before { subject }

      it do
        expect(
          a_request(:post, "#{access_token.client.site + request_directry}.json")
        ).to have_been_made.once
      end
    end

    context 'when invalid access_token' do
      let(:cassette) { "api/v2/#{request_directry}/invalid_access_token" }

      it { expect { subject }.to raise_error WeiboOAuth2::Errors::UnauthorizedError }
    end
  end
end
