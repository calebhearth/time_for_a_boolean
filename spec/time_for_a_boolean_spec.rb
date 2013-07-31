require 'time_for_a_boolean'

describe TimeForABoolean do
  it 'defines the attribute method' do
    klass.time_for_a_boolean :attribute

    expect(klass.new).to respond_to :attribute
  end

  def klass
    @klass ||= Class.new do
      extend TimeForABoolean
    end
  end
end

