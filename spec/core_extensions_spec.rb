require 'spec_helper'

describe Array do
  context '#all_empty?' do
    it 'returns true if all elements of the array are empty' do
      expect(['', '', ''].all_empty?).to be true
    end

    it 'returns false if some of the array elements are not empty' do
      expect(['', 1, '', Object.new, :a].all_empty?).to be false
    end

    it 'returns true for an empty array' do
      expect([].all_empty?).to be true
    end
  end

  context '#all_same?' do
    it 'returns true if all elements of the array are the same' do
      expect(%w(A A A).all_same?).to be true
    end

    it 'returns false if not all the elements of the array are the same' do
      expect(['', 1, '', Object.new, :a].all_same?).to be false
    end

    it 'returns true on an empty array' do
      expect([].all_same?).to be true
    end
  end

  context '#any_empty?' do
    it 'returns false if there is no empty element in the array' do
      expect(['aeee', 'A', :aaa, ['jejeje']].any_empty?).to be false
    end

    it 'returns true if at least one element of the array is empty' do
      expect(['abc', :damn, '', ['what']].any_empty?).to be true
    end

    # probably false because there is no element in array, and nil is not empty?
    it 'returns false on an empty array' do
      expect([].any_empty?).to be false
    end
  end

  context '#none_empty?' do
    it 'returns true if there are not empty elements in array' do
      expect(['aeee', 'A', :aaa, ['jejeje']].none_empty?).to be true
    end

    it 'returns false if at least one element of the array is empty' do
      expect(['abc', :damn, '', ['what']].none_empty?).to be false
    end

    # probably true because there is no element in array, and nil is not empty?
    it 'returns true on an empty array' do
      expect([].none_empty?).to be true
    end
  end
end
