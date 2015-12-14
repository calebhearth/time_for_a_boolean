require 'coveralls'
Coveralls.wear!

require 'time_for_a_boolean'

describe TimeForABoolean do
  it 'defines the attribute method' do
    klass.time_for_a_boolean :attribute

    expect(klass.new).to respond_to :attribute
  end

  it 'defines the query method' do
    klass.time_for_a_boolean :attribute

    expect(klass.new).to respond_to :attribute?
  end

  it 'defines the attribute writer' do
    klass.time_for_a_boolean :attribute

    expect(klass.new).to respond_to :attribute=
  end

  describe 'attribute method' do
    it 'calls nil? on the backing timestamp' do
      klass.time_for_a_boolean :attribute
      timestamp = double(nil?: true)
      allow(object).to receive(:attribute_at).and_return(timestamp)

      object.attribute

      expect(timestamp).to have_received(:nil?)
    end

    it 'is true if the attribute is not nil' do
      klass.time_for_a_boolean :attribute
      allow(object).to receive(:attribute_at).and_return(Time.now - 10)

      expect(object.attribute).to be_truthy
    end

    it 'is false if the attribute is nil' do
      klass.time_for_a_boolean :attribute
      allow(object).to receive(:attribute_at)

      expect(object.attribute).to be_falsey
    end

    it 'is false if the attribute time is in the future' do
      klass.time_for_a_boolean :attribute
      allow(object).to receive(:attribute_at).and_return(Time.now + 86400) # one day in the future

      expect(object.attribute).to be_falsey
    end

    context 'when the user has defined their own attribute name' do
      it 'calls nil? on the backing value' do
        klass.time_for_a_boolean :attribute, :attribute_on
        date = double(nil?: true)
        allow(object).to receive(:attribute_on).and_return(date)

        object.attribute

        expect(date).to have_received(:nil?)
      end

      it 'is true if the attribute is not nil' do
        klass.time_for_a_boolean :attribute, :attribute_on
        allow(object).to receive(:attribute_on).and_return(Date.current - 10)

        expect(object.attribute).to be_truthy
      end

      it 'is false if the attribute is nil' do
        klass.time_for_a_boolean :attribute, :attribute_on
        allow(object).to receive(:attribute_on)

        expect(object.attribute).to be_falsey
      end

      it 'is false if the attribute date is in the future' do
        klass.time_for_a_boolean :attribute, :attribute_on
        allow(object).to receive(:attribute_on).and_return(Date.current + 1)

        expect(object.attribute).to be_falsey
      end
    end
  end

  describe 'the query method' do
    it 'is an alias for the attribute method' do
      klass.time_for_a_boolean :attribute

      expect(object.method(:attribute?)).to eq object.method(:attribute)
    end
  end

  describe 'the writer method' do
    it 'sets the timestamp to now if value is true' do
      klass.time_for_a_boolean :attribute
      klass.send(:attr_accessor, :attribute_at)

      object.attribute = true

      expect(object.attribute_at).to be_kind_of(Time)
    end

    it 'sets the timestamp to nil if value is false' do
      klass.time_for_a_boolean :attribute
      klass.send(:attr_accessor, :attribute_at)

      object.attribute_at = Time.now
      object.attribute = false

      expect(object.attribute_at).to be_nil
    end

    it 'works with other representations of true' do
      klass.time_for_a_boolean :attribute
      klass.send(:attr_accessor, :attribute_at)

      object.attribute = '1'

      expect(object.attribute_at).to be_kind_of(Time)
    end

    it 'works with other representations of false' do
      klass.time_for_a_boolean :attribute
      klass.send(:attr_accessor, :attribute_at)

      object.attribute_at = Time.now
      object.attribute = '0'

      expect(object.attribute_at).to be_nil
    end
  end

  def klass
    @klass ||= Class.new do
      extend TimeForABoolean
    end
  end

  def object
    @object ||= klass.new
  end
end
