# API V1

## Resources

### User

Represents a user on the system.

Key|Type|Description
---|----|-----------
`user_id`|`Integer`|The `User` id
`username`|`String`|The `User` username

### Condition

Represents the condition of a printing.

Value|Meaning
-----|-------
`MN`|(Mint) The printing is in perfect condition
`NM`|(Near Mint) The printing is in a very good condition
`LP`|(Lightly Played) The printing was played, but still in good condition
`MP`|(Moderately Played) The printing was played a bit, but stil in acceptable condition
`HP`|(Heavily Played) The printing was played a lot, in a barely acceptable condition
`DM`|(Damaged) The printing is broken and can't be played

### Rarity

Values:

- Basic Land (Common)
- Common
- Uncommon
- Rare
- Mythic Rare
- Special

### Color

Value|Meaning
-----|-------
`R`|Red
`B`|Black
`U`|Blue
`G`|Green
`W`|White

### Supertype

Values:

- Basic
- Legendary
- Ongoing
- Snow
- World

### Type

Values:

- Artifact
- Conspiracy
- Creature
- Eaturecray
- Enchantment
- Ever
- Instant
- Land
- Phenomenon
- Plane
- Planeswalker
- Scariest
- Scheme
- See
- Sorcery
- Tribal
- Vanguard

### Deck

Represents a deck on a list of decks.

Key|Type|Description
---|----|-----------
`deck_date`|`String<DateTime:UTC>`|The date this deck was created
`deck_id`|`Integer`|The deck identifier
`deck_name`|`String`|The deck name
`card_count`|`Integer`|The amount of cards on this deck

### Card

Represents the common structure of a card that doesn't change through
editions.

Key|Type|Description
---|----|-----------
`card_color_identity`|[`Array<Color>`](#coloridentity) `NULL`|The color identity
`card_colors`|[`Array<Color>`](#color) `NULL`|The color
`card_converted_mana_cost`|`Float` `NULL`|The converted mana cost
`card_id`|`Integer`|The identifier
`card_layout`|`String`|The card layout
`card_loyalty`|`Integer` `NULL`|The loyalty (if it's a planeswalker)
`card_mana_cost`|`String` `NULL`|The mana cost
`card_name`|`String`|The name
`card_power`|`String` `NULL`|The power (if it's a creature)
`card_subtypes`|`Array<String>`|The subtypes (There are 300+ possible subtypes)
`card_supertypes`|[`Array<Supertype>`](#supertype)|The supertypes
`card_text`|`String` `NULL`|The text
`card_toughness`|`String` `NULL`|The toughness (if it's a creature)
`card_types`|[`Array<Type>`](#type)|The types
`card_type`|`String`|The type line

### CollectionCard

Represents a card on a given collection.

Key|Type|Description
---|----|-----------
`card_color_identity`|[`Array<Color>`](#coloridentity) `NULL`|The color identity
`card_converted_mana_cost`|`Float` `NULL`|The converted mana cost
`card_count`|`Integer`|The amount copies of this card
`card_id`|`Integer`|The card identifier
`card_loyalty`|`Integer` `NULL`|The loyalty (if it's a planeswalker)
`card_mana_cost`|`String` `NULL`|The mana cost
`card_name`|`String`|The name of the card
`card_power`|`String` `NULL`|The power (if it's a creature)
`card_toughness`|`String` `NULL`|The toughness (if it's a creature)

### CollectionCardDetails

Represents a card details on a given collection.

Key|Type|Description
---|----|-----------
|`CollectionCard`|Inherits `CollectionCard` values
|`Card`|Inherits `Card` values

### UserPrinting

Key|Type|Description
---|----|-----------
`user_printing_id`|`Integer`|The user printing identifier
`edition_code`|`String`|The edition code
`edition_name`|`String`|The edition name
`printing_added_date`|`String<DateTime:UTC>`|The date this printing was added to the collection
`printing_condition`|[`String<Condition>`](#condition)|The condition of the printing
`printing_flavor`|`String`|Flavor text for this printing
`printing_foil`|`Boolean`|Whether the printing is premium foil or not
`printing_multiverse_id`|`Integer` `NULL`|The gatherer's multiverse id
`printing_number`|`String` `NULL`|The printing collector number
`printing_rarity`|[`String<Rarity>`](#rarity)|The rarity of the printing
`import_id`|`Integer`|The identifier of the import this card comes from
`import_name`|`Integer`|The name of the import this card comes from

## Authorization

Authorization is handled with a JWT that should be sent in a header
in all the requests.
To get an authorization token, call the [Authenticate](#authenticate)
endpoint.

Header format:

`Authorization: Bearer <JWT>`

## Endpoints

### `POST` `/api/v1/auth`

Authenticates a user.

Key|Type|Description
---|----|-----------
`username`|`String`|The username
`password`|`String`|The password

Success:

```
Status: 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`user`|[User](#user)|The authenticated error

### `GET` `/api/v1/cards/:card_id`

Return the card details.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`card`|[Card](#card)|The card details

### `GET` `/api/v1/collection`

Returns the cards on the user collection.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`cards`|[`Array<CollectionCard>`](#collectioncard)|The collection cards

### `GET` `/api/v1/collection/:card_id`

Returns information about a card on the user collection.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`card`|[Card](#card)|The card details
`user_printings`|[`Array<UserPrinting>`](#userprinting)|The owned printings details

### `GET` `/api/v1/decks`

Returns the decks of the user.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`decks`|[`Array<Deck>`](#deck)|The decks

### `GET` `/api/v1/decks/:deck_id`

Returns the cards on a deck.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`cards`|[`Array<CollectionCard>`](#collectioncard)|The cards on the deck

### `GET` `/api/decks/:deck_id/cards/:card_id`

Returns the card details.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`details`|`CollectionCardDetails`|The details

### `GET` `/api/deck/:deck_id/cards/:card_id/alternatives`

Returns possible cards to swap a card for.

Success:

```
Status 200
Authorization: Bearer <token>
Content-Type: application/json
```

Key|Type|Description
---|----|-----------
`cards`|[`Array<DeckCard>`](#deckcard)|Card list
