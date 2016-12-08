require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test 'valid portfolio' do
    portfolio = Portfolio.new(tag_line: 'Total Event Management at low cost',bio: 'My name is Sujan', website: 'www.sujan.com', work_experience: 'Rekha Wedding', achievements:'Photographer of the year 2016', area_of_expertise:'Photography', services_offered:'Photography', works_projects:'ANA Fashion Show', service_provider_id:2)
    assert  portfolio.valid?
  end

  test 'invalid service provider without tag line' do
    portfolio = Portfolio.new(bio: 'My name is Sujan', website: 'www.sujan.com', work_experience: 'Rekha Wedding', achievements:'Photographer of the year 2016', area_of_expertise:'Photography', services_offered:'Photography', works_projects:'ANA Fashion Show', service_provider_id:2)
    refute portfolio.valid?, 'portfolio is valid without a tag line'
    assert_not_nil portfolio.errors[:company], 'no validation error for tag line present'
  end

  test 'invalid portfolio without service provider id' do
    portfolio = Portfolio.new(tag_line: 'Total Event Management at low cost',bio: 'My name is Sujan', website: 'www.sujan.com', work_experience: 'Rekha Wedding', achievements:'Photographer of the year 2016', area_of_expertise:'Photography', services_offered:'Photography', works_projects:'ANA Fashion Show')
    refute portfolio.valid?
    assert_not_nil portfolio.errors[:service_provider_id]
  end





end
