RSpec::Matchers.define :as_paginated do |expected|
  match do |actual|
    hash = {
      'current_page' => Integer,
      'total_pages' => Integer,
      'total_items' => Integer,
    }

    expect(actual).to include(
      'items' => expected || Array,
      'pagination' => hash,
    )
  end
end
