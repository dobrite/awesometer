require_relative 'awesometer'


describe Awesometer do
  before(:each) do
    @awesometer = Awesometer.new([])
  end

  describe "#initialize" do
    it "takes a single parameter" do
      initialize = @awesometer.method(:initialize)
      expect(initialize.parameters.size).to eq(1)
    end
    it "of type array" do
      expect { Awesometer.new({}) }.to raise_error
    end
    it "returns instance of type Awesometer" do
      expect(@awesometer).to be_an_instance_of(Awesometer)
    end
  end

  describe "#most" do
    before(:each) do
      @awesometer = Awesometer.new([])
    end

    it "has a method called most" do
      expect(@awesometer).to respond_to(:most)
    end
    it "returns the most awesome person" do
      candidates = [
        Person.new("leonardo", 7),
        Person.new("donatello", 10),
        Person.new("raphael", 5),
        Person.new("michelangelo", 8)
      ]
      expect(Awesometer.new(candidates).most).to equal(candidates[1])
    end
    it "returns nil for empty arrays" do
      expect(@awesometer.most).to eq(nil)
    end
    it "ties go to the left" do
      candidates = [
        Person.new("leonardo", 1),
        Person.new("donatello", 3),
        Person.new("raphael", 5),
        Person.new("michelangelo", 5)
      ]
      raphael = candidates[2]
      expect(Awesometer.new(candidates).most).to eq(raphael)
    end
    it "negatives work too" do
      candidates = [
        Person.new("leonardo", -7),
        Person.new("donatello", -10),
        Person.new("raphael", -5),
        Person.new("michelangelo", -8)
      ]
      raphael = candidates[2]
      expect(Awesometer.new(candidates).most).to eq(raphael)
    end
  end

  describe "#avg" do
    it "has a method called avg" do
      expect(@awesometer).to respond_to(:avg)
    end
    it "returns the average awesome of all persons" do
      candidates = [
        Person.new("leonardo", 7),
        Person.new("donatello", 10),
        Person.new("raphael", 5),
        Person.new("michelangelo", 8)
      ]
      expect(Awesometer.new(candidates).avg).to eq(7.5)
    end
    it "averaging an empty array raises an error" do
      expect { Awesometer.new([]).avg }.to raise_error
    end
  end

  describe "#top_ten" do
    it "has a method called top_ten" do
      expect(@awesometer).to respond_to(:top_ten)
    end
    it "prints the top ten most awesome people" do
      candidates = [
        Person.new("leonardo", 7),
        Person.new("donatello", 10),
        Person.new("raphael", 5),
        Person.new("michelangelo", 8)
      ]
      expect(Awesometer.new(candidates).top_ten).to eq(candidates[1])
    end
  end
end

describe Person, "#initialize" do
  it "should have a name" do
    person = Person.new("spinal tap", 11)
    expect(person).to respond_to(:name)
  end
  it "and an awesomeness value" do
    person = Person.new("spinal tap", 11)
    expect(person).to respond_to(:awesomeness)
  end
end
