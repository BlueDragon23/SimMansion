Broadly, the game is a resource management game about growing a mansion. The mansion has various occupants and visitors, that have various needs. 
## Key Elements

- Rooms upgrade into other rooms in a non-trivial fashion. The upgrade options shouldn't just be "Room X but better", but interesting variants. An example could be "Bedroom" upgrades into "Bunk Room" (higher capacity, less happiness), "Suite" (higher upkeep, higher happiness), or "Guest Room" (cannot be used for occupants)
- Resource management is present, but not punishing. At least on normal difficulty, it should generally be possible to get by without optimal room selection. There should be ample warning when a fail state is approaching, with the ability for the player to quickly remedy the situation. Experimentation is encouraged
- Events will take place, that force the player to adapt their strategy to the needs of the house. This could be anything from "Family comes to visit" to require extra bedrooms, "Feast day" for food, "Fire in the kitchen", etc.
- Individual members of the household are tangible entities, and may have wants/needs as well. Maybe a child needs space for education, or a teenager wants a rehearsal space

## Resources

Money and social accumulate over time. The other stats are quantities, where certain thresholds (scaled to number of people) grant certain benefits. 

- Money. Pretty simple conceptually. The main resource used to get new rooms/room upgrades. Earned by "work" rooms and some events. Expended in some higher quality rooms
	- Rooms can be disabled, to prevent entering a fail state
- Occupancy. How many beds do you have for people. Probably split into occupants + guest space
- Leisure. Artistic or athletic pursuits to relax
- Comfort. Food, lounges, bathrooms. Things that make you feel at home. Definitely overlaps with leisure in a tricky way. Some rooms will provide both, and I think that's ok
- Social. This will interact with money in some way. Doing favours and hosting people will give benefits that are less flexible, but still powerful. Think free rooms, or more positive events
- Space. You have some limits on how many rooms can be placed, that can be upgraded over time. Fun little tetris puzzle. Rooms can be reorganised easily, but are tricky shapes

## Open Questions

- How to balance rooms that provide both leisure and work? Multiple stat bonuses? Choose the purpose dynamically?
- How to handle specific needs? Some kind of "traits" on rooms?
- Is there some kind of development tree? Explicitly or hidden? You probably shouldn't get really esoteric rooms before a kitchen for example
- Multiple pathways to a given room? e.g. bathroom OR gym both upgrade to massage parlour
- Consider a tile based approach to room placement, like Dorfromantik
	- Completing events gives you extra tiles/rooms to place
	- Means choices are centred around when to add vs upgrade rooms, what upgrade trees to pursue