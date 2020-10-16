RSpec.describe ApiPack::Hello do
  it '#say!' do
    hello = ApiPack::Hello.new
    expect(hello.say!).to eq 'hello!!'
  end
end