require 'station'

describe Station do

  #subject{ described_class.new(name: "Bank") }

  it 'displays its name' do
    subject = Station.new('Bank', 1)
    expect(subject.name).to eq("Bank")
  end

  it 'displays its zone' do
    subject = Station.new('Bank', 1)
    expect(subject.zone).to eq 1
  end


end