class Edition < Sequel::Model
  UNSUPPORTED_SETS = {
    'UST': 'Unstable',
  }.freeze

  unrestrict_primary_key

  one_to_many :printings, key: 'edition_code'

  def self.supported_name?(name)
    return unless name

    !UNSUPPORTED_SETS.values.include?(name)
  end

  def self.supported?(code)
    return unless code

    !UNSUPPORTED_SETS[code]
  end
end
