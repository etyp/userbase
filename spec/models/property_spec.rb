require 'spec_helper'

describe Property do
  let(:owner) {FactoryGirl.create(:user)}

  before {@property = owner.properties.build(name: 'Test House', description: 'lorem',
  	beds: 2, baths: 1, rent: 5600)}

  subject {@property}

  it {should respond_to(:name)}
  it {should respond_to(:description)}
  it {should respond_to(:beds)}
  it {should respond_to(:baths)}
  it {should respond_to(:rent)}
  it {should respond_to(:user_id)}
  
  its(:owner) {should eq owner}

  it {should be_valid}

  describe "when user_id (owner id) is not present" do
  	before {@property.user_id = nil}
  	it {should_not be_valid}
  end

  describe "if name" do
  	describe "is blank" do
  		before{@property.name = nil}
  		it {should_not be_valid}
  	end
  	describe "is too long" do
  		before{@property.name = "a"*200}
  		it {should_not be_valid}
  	end
  end

  describe "if desc" do
  	describe "is blank" do
  		before{@property.description = nil}
  		it {should_not be_valid}
  	end
  end


  describe "if beds" do
  	describe "is blank" do
  		before{@property.beds = nil}
  		it {should_not be_valid}
  	end
  end

  describe "if baths" do
  	describe "is blank" do
  		before{@property.baths = nil}
  		it {should_not be_valid}
  	end
  end

  describe "if rent" do
  	describe "is blank" do
  		before{@property.rent = nil}
  		it {should_not be_valid}
  	end
  end


  describe "if user is not an owner" do
    let(:non_owner) {FactoryGirl.create(:user)}
    before do
      non_owner.owner = false
      non_owner.properties << @property
    end
    it "should not be able to save" do
      expect{non_owner.properties.save!}.to raise_error
    end
  end
end
