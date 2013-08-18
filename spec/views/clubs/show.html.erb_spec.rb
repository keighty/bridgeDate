require 'spec_helper'

describe "clubs/show" do
  before(:each) do
    @club = assign(:club, stub_model(Club,
      :name => "Name",
      :address => "Address",
      :city => "City",
      :state => "State",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
  end
end
