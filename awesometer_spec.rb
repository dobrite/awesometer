require 'simplecov'
SimpleCov.start

require_relative 'awesometer'


describe Awesometer do
  before(:each) do
    @awesometer = Awesometer.new([])
  end

  describe "#initialize" do
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
      candidates = (1..20).to_a.map{|x| Person.new("a", x)}
      output_spy = StringIO.new
      expected_output = "a AR: 20\na AR: 19\na AR: 18\na AR: 17\na AR: 16\n"\
                        "a AR: 15\na AR: 14\na AR: 13\na AR: 12\na AR: 11\n"
      Awesometer.new(candidates, output_spy).top_ten
      expect(output_spy.string).to eq(expected_output)
    end
    it "top_ten still works with less than 10" do
      candidates = (1..4).to_a.map{|x| Person.new("a", x)}
      output_spy = StringIO.new
      expected_output = "a AR: 4\na AR: 3\na AR: 2\na AR: 1\n"
      Awesometer.new(candidates, output_spy).top_ten
      expect(output_spy.string).to eq(expected_output)
    end
  end
end

describe Person do
  describe Person, "#initialize" do
    before(:each) do
        @person = Person.new("spinal tap", 11)
    end

    it "takes two parameters" do
        expect(@person.method(:initialize).parameters.size).to eq(2)
    end
    it "the first of type String" do
        ignore = 42
        expect { Person.new("spinal tap", ignore) }.to_not raise_error
    end
    it "the second of type Integer" do
        ignore = ""
        expect { Person.new(ignore, 11) }.to_not raise_error
    end
    it "should have a #name method" do
      expect(@person).to respond_to(:name)
    end
    it "that returns the person's name" do
      expect(@person.name).to eq("spinal tap")
    end
    it "should have an #awesomeness method" do
        expect(@person).to respond_to(:awesomeness)
    end
    it "that returns the person's awesomeness" do
      expect(@person.awesomeness).to eq(11)
    end
    it "returns an instance of type Person" do
        expect(@person).to be_an_instance_of(Person)
    end
    it "responds to <=>" do
      expect(@person).to respond_to(:<=>)
    end
    it "that compares awesomeness (eq)" do
      p1 = Person.new("spinal tap", 1)
      p2 = Person.new("spinal tap", 1)
      expect(p1 <=> p2).to eq(1 <=> 1)
    end
    it "that compares awesomeness (>)" do
      p1 = Person.new("spinal tap", 2)
      p2 = Person.new("spinal tap", 1)
      expect(p1 <=> p2).to eq(2 <=> 1)
    end
    it "that compares awesomeness (<)" do
      p1 = Person.new("spinal tap", 1)
      p2 = Person.new("spinal tap", 2)
      expect(p1 <=> p2).to eq(1 <=> 2)
    end
    it "responds to coerce" do
      expect(@person).to respond_to(:coerce)
    end
    it "allows FixNum + Person" do
      expect(10 + @person).to eq(21)
    end
    it "responds to +" do
      expect(@person).to respond_to(:+)
    end
    it "that adds awesomeness" do
      p1 = Person.new("spinal tap", 1)
      p2 = Person.new("spinal tap", 2)
      expect(p1 + p2).to eq(3)
    end
    it "to_s at least displays name" do
      expect(@person.to_s).to include(@person.name)
    end
    it "to_s at least displays awesomeness" do
      expect(@person.to_s).to include(@person.awesomeness.to_s)
    end
  end
end
