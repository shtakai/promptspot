require "test_helper"

class TestSuiteInputTest < ActiveSupport::TestCase
  setup do
    WebMock.allow_net_connect!
    VCR.insert_cassette name

    @organization = FactoryBot.create(:organization)
    @account = FactoryBot.create(:account, organization: @organization)
    @user = FactoryBot.create(:user, account: @account)
    model_provider = FactoryBot.create(:model_provider)
    @model = FactoryBot.create(:model, model_provider: model_provider)
    @prompt = FactoryBot.create(:prompt, account: @account)
    @prompt_version = FactoryBot.create(:prompt_version, prompt: @prompt, user: @user)
    @input = FactoryBot.create(:input, account: @account, user: @user)
    @test_suite = FactoryBot.create(:test_suite, account: @account, user: @user)
  end

  teardown do
    VCR.eject_cassette
    WebMock.allow_net_connect!
  end

  test "should create test suite input" do
    FactoryBot.create(:test_suite_input, test_suite: @test_suite, input: @input)
  end

  test "should not create test suite input without test suite" do
    assert_raises ActiveRecord::RecordInvalid do
      FactoryBot.create(:test_suite_input, test_suite: nil, input: @input)
    end
  end

  test "should not create test suite input without input" do
    assert_raises ActiveRecord::RecordInvalid do
      FactoryBot.create(:test_suite_input, test_suite: @test_suite, input: nil)
    end
  end

end
