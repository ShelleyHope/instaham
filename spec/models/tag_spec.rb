require 'spec_helper'

describe Tag do
  it 'is unique' do
  	Tag.create(name: '#ace')
  	duplicate = Tag.new(name: '#ace')

  	expect(duplicate).to have(1).error_on(:name)
  end
end
