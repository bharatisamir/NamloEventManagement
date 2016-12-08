require 'test_helper'

class ServiceProviderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid service provider' do
    service_provider = ServiceProvider.new(company: 'Total Event Management',business_phone: '4107711470', fax: '4107711471', user_id: 13)
    assert  service_provider.valid?
  end

  test 'invalid service provider without company' do
    service_provider = ServiceProvider.new(business_phone: '4107711470', fax: '4107711471', user_id: 13)
    refute service_provider.valid?, 'service provider is valid without a company'
    assert_not_nil service_provider.errors[:company], 'no validation error for company present'
  end

  test 'invalid service provider without user id' do
    service_provider = ServiceProvider.new(company: 'Total Event Management',business_phone: '4107711470', fax: '4107711471')
    refute service_provider.valid?
    assert_not_nil service_provider.errors[:user_id]
  end


end
