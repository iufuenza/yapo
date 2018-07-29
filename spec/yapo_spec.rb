RSpec.describe Yapo do
  it "has a version number" do
    expect(Yapo::VERSION).not_to be nil
  end

  it "loads configurations (list of commands defined in .yapo.yml)" do
    expect(Yapo.configurations).not_to be nil
  end
end
