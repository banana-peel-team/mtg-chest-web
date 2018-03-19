def insert_records(table, columns, data)
  from(table)
    .import(columns, data, slice: data.count)
  puts " >> Inserted #{data.count} records on #{table}."
  data.clear
end

def convert_records(table, columns, count_column)
  cache = []

  original_count = from(table).sum(count_column) || 0

  records = from(table)
    .where(Sequel.lit(count_column.to_s) > 1)
    .select_map(columns + [count_column])

  drop_column(table, count_column)

  records.each do |record|
    count = record.pop
    (count - 1).times { cache << record }

    insert_records(table, columns, cache) if cache.count > 80
  end

  insert_records(table, columns, cache) if cache.any?

  current_count = from(table).count

  if current_count != original_count
    puts " The total cards on #{table} is not valid"
    puts "   -> Before: #{original_count}"
    puts "   -> After:  #{current_count}"

    fail "Process failed"
  end
end

Sequel.migration do
  up do
    columns = [
      :user_id, :import_id, :printing_id, :foil,
      :added_date, :condition
    ]

    convert_records(:user_printings, columns, :count)

    columns = [
      :deck_id, :card_id, :added_at
    ]

    convert_records(:deck_cards, columns, :card_count)
  end

  down do
    add_column(:deck_cards, :card_count, Numeric, null: true)
    from(:deck_cards).update(card_count: 1)

    alter_table(:deck_cards) do
      set_column_not_null(:card_count)
    end

    add_column(:user_printings, :count, Numeric, null: true)
    from(:user_printings).update(count: 1)

    alter_table(:user_printings) do
      set_column_not_null(:count)
    end
  end
end
