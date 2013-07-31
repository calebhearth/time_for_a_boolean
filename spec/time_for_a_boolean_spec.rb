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
      timestamp = double(nil?: false)
      object.stub(attribute_at: timestamp)

      object.attribute

      expect(timestamp).to have_received(:nil?)
    end

    it 'is true if the attribute is not nil' do
      klass.time_for_a_boolean :attribute
      object.stub(attribute_at: true)

      expect(object.attribute).to be_true
    end

    it 'is false if the attribute is nil' do
      klass.time_for_a_boolean :attribute
      object.stub(attribute_at: nil)

      expect(object.attribute).to be_false
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

      expect(object.attribute_at).to be_kind_of(DateTime)
    end

    it 'sets the timestamp to nil if value is false' do
      klass.time_for_a_boolean :attribute
      klass.send(:attr_accessor, :attribute_at)

      object.attribute_at = DateTime.now
      object.attribute = false

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
