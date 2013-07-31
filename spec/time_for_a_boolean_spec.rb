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

  it 'defines the attribute setter' do
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

    def object
      @object ||= klass.new
    end
  end

  def klass
    @klass ||= Class.new do
      extend TimeForABoolean
    end
  end
end

